class User < ActiveRecord::Base
  has_many :messages
  has_many :swipes
  has_many :seen_users, class_name: 'User', through: :swipes
  has_many :pools, through: :pool_profiles
  has_many :pool_profiles 
  has_and_belongs_to_many :pods
end
