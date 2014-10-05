class Pool < ActiveRecord::Base
  has_many :users, through: :pool_profiles
  has_many :pool_profiles
  has_many :pods
  belongs_to :creator, class_name: 'User'
end
