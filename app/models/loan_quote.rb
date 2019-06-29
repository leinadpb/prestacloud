class LoanQuote < ApplicationRecord

  def sanitazed_info
    {
        id: id,
        amount: amount,
        state: state,
        payment_method: payment_method,
        expiry_date: expiry_date,
        created_at: created_at
    }
  end
end
