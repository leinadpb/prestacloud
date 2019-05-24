class AddArticleTypeToArticle < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :article_type, index: true, foreign_key: true
  end
end
