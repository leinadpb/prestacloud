module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_user_client
      # if you have rails_admin. You can redirect anywhere really
      return
    elsif current_user
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      return
    end
  end
end