class CreateLoanQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_quotes do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :state
      t.string :payment_method

      t.timestamps
    end
  end
end
