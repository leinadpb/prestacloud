class Article < ApplicationRecord
  has_many :log_articles
  belongs_to :article_state


  def sanitazed_info_with_loan
    {
        id: id,
        name: name,
        description: description,
        category_type: ::ArticleType.find(article_type_id),
        loan: ::Loan.find(loan_id),
        weight: 0
    }
  end

  def sanitazed_info
    {
        id: id,
        name: name,
        description: description,
        category_type: ::ArticleType.find(article_type_id).sanitazed_info,
        weight: 0
    }
  end

end
