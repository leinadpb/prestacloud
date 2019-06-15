module ArticlesService
  class << self

    def create_many(articles, created_loan)
      if !articles.empty?
        articles_to_create = []
        articles.each do |art|
          articles_to_create.push(
        {
              name: art[:name],
              description: art[:description],
              article_type_id: art[:article_type_id],
              real_price: art[:real_price],
              agreement_price: art[:agreement_price],
              loan_id: created_loan[:id],
              article_state_id: 1})
        end
        ::Article.create!(articles_to_create)
      end
    end

  end
end