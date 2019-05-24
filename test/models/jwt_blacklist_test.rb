require 'test_helper'

class JwtBlacklistTest < ActiveSupport::TestCase
  include Devise::JWT::RevocationStrategies::Blacklist

  self.table_name = 'jwt_blacklist'
end
