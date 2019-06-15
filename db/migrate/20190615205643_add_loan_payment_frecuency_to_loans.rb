class AddLoanPaymentFrecuencyToLoans < ActiveRecord::Migration[5.2]
  def change
    add_reference :loans, :loan_payment_frecuency, :foreign_key => true
  end
end
