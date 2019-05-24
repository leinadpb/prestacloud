class AddArticleStateToArticle < ActiveRecord::Migration[5.2]
  def change
    add_reference :articles, :article_state, index: true, foreign_key: true
  end
end
