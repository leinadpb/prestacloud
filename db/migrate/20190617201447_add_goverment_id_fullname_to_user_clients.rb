class AddGovermentIdFullnameToUserClients < ActiveRecord::Migration[5.2]
  def change
    add_column :user_clients, :goverment_id, :string
    add_column :user_clients, :full_name, :string
  end
end
