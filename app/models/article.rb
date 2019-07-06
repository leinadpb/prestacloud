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
        weight: 0,
        real_price: real_price,
        agreement_price: agreement_price,
        state: ArticleState.find(article_state_id)
    }
  end

  def sanitazed_info
    {
        id: id,
        name: name,
        description: description,
        category_type: ::ArticleType.find(article_type_id).sanitazed_info,
        weight: 0,
        real_price: real_price,
        agreement_price: agreement_price,
        state: ArticleState.find(article_state_id)
    }
  end

  def return_to_client
    self.article_state_id = 3
    self.save!
  end
  def kept_for_store
    self.article_state_id = 4
    self.save!
  end

end
