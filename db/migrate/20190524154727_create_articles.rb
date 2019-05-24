class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :description
      t.decimal :real_price, precision: 7, scale: 2
      t.decimal :agreement_price, precision: 7, scale: 2

      t.timestamps
    end
  end
end
