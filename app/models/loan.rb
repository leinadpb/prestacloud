class Loan < ApplicationRecord
  has_one :loan_detail
  has_one :loan_state
  has_one :loan_payment_frecuency
  belongs_to :client

  def calculate_cost
    cost = (amount * tax) + amount
    cost
  end

  def sanitazed_info
    {
        id: id,
        amount_to_pay: calculate_cost,
        appraise: appraise,
        observations: observations,
        client: ::Client.find(client_id),
        employee: ::User.find(user_id),
        category: ::LoanCategory.find(loan_category_id),
        articles: ::Article.where(loan_id: id).map(&:sanitazed_info),
        quotes: ::LoanQuote.where(loan_id: id).map(&:sanitazed_info).sort_by{|q| q[:expiry_date]},
        frecuency: ::LoanPaymentFrecuency.find(loan_payment_frecuency_id),
        amount_appraise: amount_appraise,
        tax: tax,
        duration: loan_duration,
        status: status
    }
  end

  def sanitazed_info_without_client
    {
        id: id,
        amount_to_pay: calculate_cost,
        appraise: appraise,
        amount_appraise: amount_appraise,
        observations: observations,
        employee: ::User.find(user_id),
        category: ::LoanCategory.find(loan_category_id),
        frecuency: ::LoanPaymentFrecuency.find(loan_payment_frecuency_id),
        articles: ::Article.where(loan_id: id).map(&:sanitazed_info),
        quotes: ::LoanQuote.where(loan_id: id).map(&:sanitazed_info).sort_by{|q| q[:expiry_date]},
        tax: tax,
        duration: loan_duration,
        status: status
    }
  end


end
