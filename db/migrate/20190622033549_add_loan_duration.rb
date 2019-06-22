class AddLoanDuration < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :loan_duration, :integer
  end
end
