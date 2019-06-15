class CreateLoanStates < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_states do |t|
      t.string :description
      t.string :name
      t.timestamps
    end
  end
end
