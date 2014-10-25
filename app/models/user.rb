class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:github]

  has_many :messages
  has_many :swipes, -> { queue }
  has_many :seen_pool_profiles, class_name: 'PoolProfile', through: :swipes
  has_many :pools, through: :pool_profiles
  has_many :pool_profiles
  has_and_belongs_to_many :pods
  has_many :created_pools, class_name: 'Pool', foreign_key: 'creator_id'
  has_many :message_views, -> { message }, class_name: 'ResourceView'

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

  def new_message_count
    total_unseen = 0

    self.pods.each do |pod|
      msg_view = self.message_views.find_by(viewable: pod)

      viewed_at = msg_view.try(:last_viewed_at)

      if viewed_at.present?
        total_unseen += pod.messages.where('created_at >= ?', viewed_at).size
      else
        total_unseen += pod.messages.all.size
      end
    end

    total_unseen
  end

end
