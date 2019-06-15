class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JwtBlacklist

  after_create :assign_default_role

  has_one :business

  has_one_attached :profile_picture

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def sanitized_info
    {
        id: id,
        email: email,
        roles: roles.map(&:name),
        full_name: full_name
    }
  end

end
