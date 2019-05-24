class Article < ApplicationRecord
  has_many :log_articles
  belongs_to :article_state
end
