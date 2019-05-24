class AddFrecuencyToArticleType < ActiveRecord::Migration[5.2]
  def change
    add_reference :article_types, :frecuency, index: true, foreign_key: true
  end
end
