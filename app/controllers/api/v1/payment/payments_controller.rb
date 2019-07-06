class Api::V1::Payment::PaymentsController < ApplicationController
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  def pay_quote
    isCash = params[:type] == "cash" ? true : false
    quote = ::LoanQuote.find(params[:quote_id])
    loan = ::Loan.find(params[:loan_id])
    amount = params[:amount].to_f # only when cash

    client = ::UserClient.find_by(:goverment_id => params[:goverment_id])
    if quote.present? and client.present?
      if quote[:amount] == 0
        render json: { message: "Quote is payed complete." }
      end

      if isCash
        if amount <= 0
          render json: { message: "Insufficient funds." }
        end
        loan[:amount] = loan[:amount] - quote[:amount]
        amount_to_return = execute_quote_payment(quote, "cash", amount, client)
        loan.save!
        verify_loan_complete(loan)
        render json: {
            quote: quote,
            amount_to_return: amount_to_return,
            loan: loan.sanitazed_info
        }, :status => :ok
      else
        amount_to_pay = (quote[:amount] * 100).round
        charge = Stripe::Charge.create({
             amount: amount_to_pay,
             currency: 'dop',
             customer: client[:stripe_id],
         })
        if charge[:status] == "succeeded"
          loan[:amount] = loan[:amount] - quote[:amount]
          execute_quote_payment(quote, "card", quote[:amount], client)
          loan.save!
          verify_loan_complete(loan)
          render json: {
              quote: quote,
              amount_to_return: 0,
              loan: loan.sanitazed_info
          }, :status => :ok
        end
      end
    else
      render json: {
          message: "Loan quote or client not found: #{params[:quote_id]}. Client: #{client}"
      }, :status => :bad_request
    end
  end

  def verify_loan_complete(loan)
    loan_quotes = ::LoanQuote.where(:loan_id => loan[:id])
    complete = true
    loan_status = "on-time"
    loan_quotes.each do |quote|
      if quote[:amount] > 0
        complete = false
      end
      expiry_date = quote[:expiry_date]
      if Time.now > expiry_date
        loan_status = "expired"
      end
    end
    if complete
      loan[:status] = loan_status
      loan.save!
      loan_articles = ::Article.where(loan_id: loan[:id])
      loan_articles.each do |article|
        if loan_status == "on-time"
          article.return_to_client
        else
          article.kept_for_store
        end
      end
    end
  end

  def execute_quote_payment(quote, type, amount, client)
    amount_to_return = 0
    to_charge_amount = quote[:amount]
    if amount > quote[:amount]
      amount_to_return = amount - quote[:amount]
    end
    if amount < quote[:amount]
      to_charge_amount = amount
    end
    quote_amount_value = quote[:amount] - amount
    quote[:payment_method] = type
    quote[:amount] = (quote_amount_value < 0) ? 0 : quote_amount_value
    if quote_amount_value <= 0
      quote.state = "complete"
    else
      quote.state = "partial"
    end
    quote.save!
    create_quote_payment(quote, to_charge_amount, client)
    amount_to_return
  end

  def pay_full_loan
    isCash = params[:type] == "cash" ? true : false
    loan = ::Loan.find(params[:loan_id])
    loan_quotes = ::LoanQuote.where(:loan_id => loan[:id])
    client = ::UserClient.find_by(:goverment_id => params[:goverment_id])
    total_due = 0
    loan_quotes.each do |q|
      total_due += q[:amount]
    end
    if isCash
      amount = params[:amount].to_f # only when cash

      if amount >= total_due
        loan_status = "on-time"
        loan_quotes.each do |quote|
          quote[:amount] = 0
          quote[:payment_method] = "cash"
          quote[:state] = "complete"
          expiry_date = quote[:expiry_date]
          if Time.now > expiry_date
            loan_status = "expired"
          end
          quote.save!
        end
        loan[:status] = loan_status
        loan[:amount] = 0
        loan.save!
        if loan[:status] == "expired"
          kept_loan_articles(loan)
        end
        render json: {
            message: 'Succesfull payment',
            loan: loan.sanitazed_info,
            amount_to_return: (amount - total_due)
        }, :status => :ok
      else
        render json: {
            message: "Insufficient amount"
        }
      end
    else
      amount_to_pay = (total_due * 100).round
      charge = Stripe::Charge.create({
         amount: amount_to_pay,
         currency: 'dop',
         customer: client[:stripe_id],
       })
      loan_status = "on-time"
      loan_quotes.each do |quote|
        quote[:amount] = 0
        quote[:payment_method] = "card"
        quote[:state] = "complete"
        expiry_date = quote[:expiry_date]
        if Time.now > expiry_date
          loan_status = "expired"
        end
        quote.save!
      end
      loan[:status] = loan_status
      loan[:amount] = 0
      loan.save!
      if loan[:status] == "expired"
        kept_loan_articles(loan)
      end
      if charge[:status] == "succeeded"
        render json: {
            loan: loan.sanitazed_info,
            amount_to_return: 0
        }, :status => :ok
      end
    end
  end

  def kept_loan_articles(loan)
    loan_articles = ::Article.find_by(:loan_id => loan[:id])
    loan_articles.each do |article|
      article.kept_for_store
    end
  end

  def create_quote_payment(quote, quote_amount, client)
    ::QuotePayment.create!(loan_quotes_id: quote[:id], amount: quote_amount, payment_method: quote[:payment_method], user_clients_id: client[:id])
  end

end
