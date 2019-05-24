class AddLoanDetailToLoans < ActiveRecord::Migration[5.2]
  def change
    add_reference :loans, :loan_detail, foreign_key: true
  end
end
