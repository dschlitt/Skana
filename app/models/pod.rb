class Pod < ActiveRecord::Base
  acts_as_paranoid
  has_many :messages
  has_and_belongs_to_many :users
  belongs_to :pool
  has_many :message_views, -> { message }, as: :viewable,
    class_name: 'ResourceView'
end
