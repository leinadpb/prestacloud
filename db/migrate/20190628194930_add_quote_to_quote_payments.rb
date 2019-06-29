class AddQuoteToQuotePayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :quote_payments, :loan_quotes, :foreign_key => true
  end
end
