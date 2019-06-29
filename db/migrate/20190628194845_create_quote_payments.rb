class CreateQuotePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :quote_payments do |t|

      t.timestamps
    end
  end
end
