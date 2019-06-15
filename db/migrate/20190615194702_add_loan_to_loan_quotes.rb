class AddLoanToLoanQuotes < ActiveRecord::Migration[5.2]
  def change
    add_reference :loan_quotes, :loan, :foreign_key => true
  end
end
