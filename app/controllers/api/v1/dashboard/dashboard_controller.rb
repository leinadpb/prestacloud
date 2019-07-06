class Api::V1::Dashboard::DashboardController < ApplicationController

  def get_data
    total_clients = ::Client.count
    total_loans = ::Loan.count
    total_articles = ::Article.count

    days_to_count = params[:days].to_i
    day_data_list = []
    while days_to_count >= 0 do

      days_ago = (Time.now - days_to_count.days)
      day_ago = (Time.now - (days_to_count - 1).days)

      @total_income = 0

      loans = ::Loan.where('created_at >= ? and created_at <= ?', days_ago, day_ago)

      if loans.any?
        loans.each { |loan|
          if loan[:status] == "on-time" or loan[:status] == "complete" or loan[:status] == "expired"
            @total_income += loan[:appraise] * loan[:tax]
          end
        }
      end

      day_data_list.append ({
          total_income: @total_income,
          label: days_ago.strftime("%m/%d/%y"),
          from: days_ago.strftime("%Y%m%d"),
          to: day_ago.strftime("%Y%m%d")
      })

      days_to_count -= 1
    end

    render json: {
        total_clients: total_clients,
        total_loans: total_loans,
        total_articles: total_articles,
        day_data_list: day_data_list,
        income: ::Loan.all.map(&:calculate_cost_appraise).sum

    }, :status => :ok

  end

end
