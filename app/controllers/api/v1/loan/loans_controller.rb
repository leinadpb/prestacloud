class Api::V1::Loan::LoansController < ApplicationController

  def create

    loan = ::LoansService.create(create_loan_params, @user)
    articles = ArticlesService.create_many(create_articles_params, loan)
    quotes = ::LoansService.calculate_quotes(loan)

    puts '>>>>>>>>'
    puts articles.inspect
    puts quotes.inspect

    if !articles.empty?
      render json: {
          loan: loan.sanitazed_info,
          quotes: quotes
      }
    else
      render json: {
          message: "Couldn't create associated articles to this loan, try again"
      }, :status => :not_found
    end


  end


  private

    def create_loan_params
      params.require(:loan).permit(:amount_to_pay, :category_id, :client_id, :appraise, :observations, :loan_payment_frecuency_id)
    end

    def create_articles_params
      params.require(:articles)
    end

end
