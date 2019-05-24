class AddPaymentReceiptToAccountsReceivable < ActiveRecord::Migration[5.2]
  def change
    add_reference :accounts_receivables, :payment_receipt, index: true, foreign_key: true
  end
end
