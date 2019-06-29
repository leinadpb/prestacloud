class AddStripeIdToUserClients < ActiveRecord::Migration[5.2]
  def change
    add_column :user_clients, :stripe_id, :string
  end
end
