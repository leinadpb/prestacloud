class CreateBusinesses < ActiveRecord::Migration[5.2]
  def change
    create_table :businesses do |t|
      t.string :name
      t.decimal :latitude, precision: 7, scale: 2
      t.decimal :longitude, precision: 7, scale: 2
      t.string :address
      t.string :phone
      t.string :owner

      t.timestamps
    end
  end
end
