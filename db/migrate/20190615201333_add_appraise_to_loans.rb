class AddAppraiseToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :appraise, :decimal, precision: 10, scale: 2
  end
end
