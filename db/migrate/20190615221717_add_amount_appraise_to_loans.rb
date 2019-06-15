class AddAmountAppraiseToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :amount_appraise, :decimal, precision: 10, scale: 2
  end
end
