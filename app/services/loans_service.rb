module LoansService
  class << self
    def create(loan, client, employee)
      ::Loan.create!(
          loan_category_id: loan[:category_id],
          appraise: loan[:appraise],
          observations: loan[:observations],
          client_id: client[:id],
          user_id: 1,
          loan_states_id: 1,
          tax: 0.18,
          loan_duration: loan[:loan_duration],
          status: "open",
          loan_payment_frecuency_id: loan[:loan_payment_frecuency_id])
    end


    def calculate_quotes(loan)
      total = ::Article.where(loan_id: loan[:id]).map(&:agreement_price).sum
      total_appraise = ::Article.where(loan_id: loan[:id]).map(&:real_price).sum

      update_loan_total(loan, total, total_appraise)
      payment_frecuency = ::LoanPaymentFrecuency.find(loan[:loan_payment_frecuency_id])
      frecuency_weeks = payment_frecuency[:value]

      total_quotes = (loan[:loan_duration].to_i  * 4) / frecuency_weeks

      puts total_quotes

      quote_price = ( (total + (total * loan[:tax].to_f) ) / total_quotes).ceil
      quotes = []
      total_quotes.times do |quote|
        exp_days = (quote + 1) * (frecuency_weeks * 7)
        quotes.push({amount: quote_price, state: 'new', payment_method: nil, loan_id: loan[:id], expiry_date: exp_days.days.from_now})
      end
      ::LoanQuote.create!(quotes)
    end

    def update_loan_total(loan, total, total_appraise)
      ::Loan.find(loan[:id]).update!(amount: total, appraise: total, amount_appraise: total_appraise)
    end
  end
end