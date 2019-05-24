class AddArticleToLogArticles < ActiveRecord::Migration[5.2]
  def change
    add_reference :log_articles, :article, index: true, foreign_key: true
  end
end
