class Loan < ApplicationRecord
  has_one :loan_detail
  has_one :loan_state
  has_one :loan_payment_frecuency
  belongs_to :client

  def sanitazed_info
    {
        id: id,
        amount_to_pay: amount,
        appraise: appraise,
        observations: observations,
        client: ::Client.find(client_id),
        employee: ::User.find(user_id),
        category: ::LoanCategory.find(loan_category_id),
        articles: ::Article.where(loan_id: id).map(&:sanitazed_info),
        frecuency: ::LoanPaymentFrecuency.find(loan_payment_frecuency_id),
        amount_appraise: amount_appraise
    }
  end

  def sanitazed_info_without_client
    {
        id: id,
        amount_to_pay: amount,
        appraise: appraise,
        observations: observations,
        employee: ::User.find(user_id),
        category: ::LoanCategory.find(loan_category_id),
        frecuency: ::LoanPaymentFrecuency.find(loan_payment_frecuency_id),
        articles: ::Article.where(loan_id: id).map(&:sanitazed_info),
        quotes: ::LoanQuote.where(loan_id: id).map(&:sanitazed_info)
    }
  end

end
