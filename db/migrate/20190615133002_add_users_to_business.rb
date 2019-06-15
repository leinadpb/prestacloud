class AddUsersToBusiness < ActiveRecord::Migration[5.2]
  def change
    add_reference :businesses, :user, foreing_key: true
  end
end
