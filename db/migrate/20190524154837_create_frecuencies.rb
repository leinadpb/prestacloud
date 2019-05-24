class CreateFrecuencies < ActiveRecord::Migration[5.2]
  def change
    create_table :frecuencies do |t|
      t.string :description
      t.decimal :value, precision: 7, scale: 2

      t.timestamps
    end
  end
end
