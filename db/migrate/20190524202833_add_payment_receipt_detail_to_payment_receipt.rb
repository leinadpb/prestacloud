class AddPaymentReceiptDetailToPaymentReceipt < ActiveRecord::Migration[5.2]
  def change
    add_reference :payment_receipts, :payment_receipt_detail, index: true, foreign_key: true
  end
end
