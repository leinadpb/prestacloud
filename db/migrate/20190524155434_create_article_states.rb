class CreateArticleStates < ActiveRecord::Migration[5.2]
  def change
    create_table :article_states do |t|
      t.string :descripcion
      t.string :name

      t.timestamps
    end
  end
end
