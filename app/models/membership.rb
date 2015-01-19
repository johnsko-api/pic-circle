class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle
  validates_uniqueness_of :user_id, scope: [:circle_id]
end
