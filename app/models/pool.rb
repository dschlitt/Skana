class Pool < ActiveRecord::Base
  extend FriendlyId

  has_many :users, through: :pool_profiles
  has_many :pool_profiles
  has_many :pods
  belongs_to :creator, class_name: 'User'


  friendly_id :slug_candidates, use: :slugged

  private

  def slug_candidates
    [
      :name,
      [:name, :location_name],
      [:name, :location_name, :id]
    ]
  end

end
