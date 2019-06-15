class CreateLoanPaymentFrecuencies < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_payment_frecuencies do |t|
      t.integer :value
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
