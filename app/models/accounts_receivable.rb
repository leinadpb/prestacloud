class AccountsReceivable < ApplicationRecord
  has_one :payment_receipt
end
