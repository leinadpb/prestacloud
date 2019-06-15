class AddLoanStateToLoans < ActiveRecord::Migration[5.2]
  def change
    add_reference :loans, :loan_states, :foreign_key => true
  end
end
