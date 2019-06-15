class AddObservationsToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :observations, :string
  end
end
