class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages
  has_many :swipes
  has_many :seen_users, class_name: 'User', through: :swipes
  has_many :pools, through: :pool_profiles
  has_many :pool_profiles
  has_and_belongs_to_many :pods
  has_many :created_pools, class_name: 'Pool', foreign_key: 'creator_id'
end
