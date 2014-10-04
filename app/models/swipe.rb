class Swipe < ActiveRecord::Base
  belongs_to :user
  belongs_to :seen_user, class_name: "User"
  belongs_to :pool
end
