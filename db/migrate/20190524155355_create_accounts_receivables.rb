class CreateAccountsReceivables < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts_receivables do |t|
      t.string :status
      t.decimal :amount, precision: 7, scale: 2
      t.date :expiration_date
      t.boolean :payed

      t.timestamps
    end
  end
end
