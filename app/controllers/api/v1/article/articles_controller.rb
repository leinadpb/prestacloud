class Api::V1::Article::ArticlesController < ApplicationController

  def show
    client = ::UserClient.find_by(:goverment_id => params[:goverment_id])
    client_loans = ::Loan.find_by(client_id: client[:id])
    render json: {
        loans: client_loans.map(&:sanitazed_info_without_client)
    }, :status => :ok
  end

  def show_for_complete_loans
    client = ::UserClient.find_by(:goverment_id => params[:goverment_id])
    client_loans = ::Loan.find_by(client_id: client[:id])
    loans = client_loans.map(&:sanitazed_info_without_client)
    return_value = []
    loans.each do |loan|
      if loan[:status] == "complete"
        return_value.push(loan)
      end
    end
    render json: {
        loans: return_value
    }, :status => :ok
  end

  def return_article
    article = ::Article.find(params[:article_id])
    article[:article_state_id] = 3
    article.save!
    render json: {
        article: article
    }, :status => :ok
  end


end
