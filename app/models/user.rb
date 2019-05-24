class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  after_create :assign_default_role

  def assign_default_role
    add_role(:user) if role.blank?
  end

  def sanitized_info
    {
        id: id,
        email: email,
        roles: roles.map(&:name)
    }
  end

end
