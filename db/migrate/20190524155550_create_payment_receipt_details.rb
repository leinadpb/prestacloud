class CreatePaymentReceiptDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_receipt_details do |t|
      t.decimal :amount, precision: 7, scale: 2

      t.timestamps
    end
  end
end
