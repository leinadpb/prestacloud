module LoansService
  class << self
    def create(loan, employee)
      ::Loan.create!(
          amount: loan[:amount_to_pay],
          loan_category_id: loan[:category_id],
          appraise: loan[:appraise],
          observations: loan[:observations],
          client_id: loan[:client_id],
          user_id: employee[:id],
          loan_states_id: 1,
          loan_payment_frecuency_id: loan[:loan_payment_frecuency_id])
    end


    def calculate_quotes(loan)
      total = ::Article.where(loan_id: loan[:id]).map(&:agreement_price).sum

      update_loan_total(loan, total)
      payment_frecuency = ::LoanPaymentFrecuency.find(loan[:loan_payment_frecuency_id])
      frecuency_weeks = payment_frecuency[:value]

      quote_price = (total / frecuency_weeks).ceil
      quotes = []
      frecuency_weeks.times do |week|
        exp_days = (week + 1) * 7
        quotes.push({amount: quote_price, state: 'new', payment_method: nil, loan_id: loan[:id], expiry_date: exp_days.days.from_now})
      end
      ::LoanQuote.create!(quotes)
    end

    def update_loan_total(loan, total)
      ::Loan.find(loan[:id]).update!(amount: total)
    end
  end
end