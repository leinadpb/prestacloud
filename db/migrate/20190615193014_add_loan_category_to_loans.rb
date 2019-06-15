class AddLoanCategoryToLoans < ActiveRecord::Migration[5.2]
  def change
    add_reference :loans, :loan_category, :foreign_key => true
  end
end
