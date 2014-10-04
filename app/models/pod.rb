class Pod < ActiveRecord::Base
  has_many :messages
  has_and_belongs_to_many :users
  belongs_to :pool
end
