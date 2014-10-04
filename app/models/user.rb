class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:github]

  has_many :messages
  has_many :swipes
  has_many :seen_users, class_name: 'User', through: :swipes
  has_many :pools, through: :pool_profiles
  has_many :pool_profiles
  has_and_belongs_to_many :pods
  has_many :created_pools, class_name: 'Pool', foreign_key: 'creator_id'

  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |u|
      u.name = auth.info.name || auth.info.nickname
    end
    user.email = auth.info.email
    user.password = Devise.friendly_token
    user.avatar = auth.info.image # assuming the user model has an image
    user.save
    user
  end

  def self.new_with_session(params, session)
    raise StandardError.new "Hello"
    super.tap do |user|
      puts session["devise.github_data"].inspect
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.avatar = data["info"]["image"] # assuming the user model has an image
      end
    end
  end
end
