class Loan < ApplicationRecord
  has_one :loan_detail
  has_one :loan_state
  belongs_to :loan_payment_frecuency

  def sanitazed_info
    {
        id: id,
        amount_to_pay: amount,
        appraise: appraise,
        observations: observations,
        client: ::Client.find(client_id),
        employee: ::User.find(user_id),
        category: ::LoanCategory.find(loan_category_id),
        articles: ::Article.where(loan_id: id).map(&:sanitazed_info)
    }
  end
end
