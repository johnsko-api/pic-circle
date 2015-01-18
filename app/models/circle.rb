class Circle < ActiveRecord::Base
  has_many :users, through: :memberships
  belongs_to :user
  has_many :comments
  has_many :pictures
  has_many :memberships
end
