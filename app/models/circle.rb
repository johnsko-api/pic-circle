class Circle < ActiveRecord::Base
  has_many :users
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :memberships
end
