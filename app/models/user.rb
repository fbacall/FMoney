class User < ApplicationRecord

  has_many :sources
  has_many :rules
  has_many :categories
  has_many :transactions

  def self.from_omniauth(auth_hash)
    User.where(provider: auth_hash['provider'], uid: auth_hash['uid']).first_or_create
  end

end
