class ResourceView < ActiveRecord::Base
  belongs_to :viewable, polymorphic: true
  belongs_to :user

  scope :message, -> {
    where(resource_type: 'Message')
  }
end
