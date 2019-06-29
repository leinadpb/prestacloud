class Api::V1::Payment::PaymentsController < ApplicationController
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  def pay_quote
    isCash = params[:type] == "cash" ? true : false
    quote = ::LoanQuote.find(params[:quote_id])
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
        amount_to_return = execute_quote_payment(quote, "cash", amount, client)
        render json: {
            quote: quote,
            amount_to_return: amount_to_return
        }, :status => :ok
      else
        amount_to_pay = (quote[:amount] * 100).round
        charge = Stripe::Charge.create({
             amount: amount_to_pay,
             currency: 'dop',
             customer: client[:stripe_id],
         })
        if charge[:status] == "succeeded"
          execute_quote_payment(quote, "card", quote[:amount], client)
          render json: {
              quote: quote,
              amount_to_return: 0
          }, :status => :ok
        end
      end
    else
      render json: {
          message: "Loan quote or client not found: #{params[:quote_id]}. Client: #{client}"
      }, :status => :bad_request
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

  def create_quote_payment(quote, quote_amount, client)
    ::QuotePayment.create!(loan_quotes_id: quote[:id], amount: quote_amount, payment_method: quote[:payment_method], user_clients_id: client[:id])
  end
end
