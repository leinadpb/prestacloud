class CreateLoanDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_details do |t|
      t.date :expiration_date

      t.timestamps
    end
  end
end
