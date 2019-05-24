class AddClientToLoan < ActiveRecord::Migration[5.2]
  def change
    add_reference :loans, :client, index: true, foreign_key: true
  end
end
