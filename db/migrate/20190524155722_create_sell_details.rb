class CreateSellDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :sell_details do |t|
      t.decimal :amount, precision: 7, scale: 2

      t.timestamps
    end
  end
end
