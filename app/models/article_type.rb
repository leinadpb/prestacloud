class ArticleType < ApplicationRecord
  belongs_to :frecuency

  def sanitazed_info
    {
        id: id,
        description: description
    }
  end
end
