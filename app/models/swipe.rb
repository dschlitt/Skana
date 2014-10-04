class Swipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :seen_pool_profile, class_name: "PoolProfile"
  belongs_to :pool

  scope :queue, -> { order(count: :asc) }
end
