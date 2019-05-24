class CreateLogArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :log_articles do |t|
      t.integer :previous_state
      t.integer :next_state

      t.timestamps
    end
  end
end
