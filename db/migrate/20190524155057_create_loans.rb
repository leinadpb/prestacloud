class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.decimal :amount, precision: 7, scale: 2
      t.string :status
      t.decimal :tax, precision: 7, scale: 2

      t.timestamps
    end
  end
end
