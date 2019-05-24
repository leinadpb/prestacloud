class CreateArticleTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :article_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
