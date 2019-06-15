class AddLoanToArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :loan, :foreign_key => true
  end
end
