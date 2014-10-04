class Pool < ActiveRecord::Base
  has_many :users, through: :pool_profiles
  has_many :pool_profiles
end
