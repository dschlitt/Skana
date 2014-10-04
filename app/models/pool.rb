class Pool < ActiveRecord::Base
  has_many :users, through: :pool_profiles
  has_many :pool_profiles
  has_many :pods
  has_one :creator, class_name: 'User'
end
