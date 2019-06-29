class AddMissingFieldsToQuotePayment < ActiveRecord::Migration[5.2]
  def change
    add_column :quote_payments, :amount, :decimal, precision: 7, scale: 2
    add_reference :quote_payments, :user_clients, :foreign_key => true
    add_column :quote_payments, :payment_method, :string
  end
end
