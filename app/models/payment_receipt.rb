class PaymentReceipt < ApplicationRecord
  belongs_to :accounts_receivable
  has_one :payment_receipt_detail
end
