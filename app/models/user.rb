class User < ActiveRecord::Base
  has_many :messages
  has_many :seen_users
  has_many :pools, through: :pool_profiles
  has_many :pool_profiles 
  has_and_belongs_to_many :pods
end
