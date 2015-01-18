class Circle < ActiveRecord::Base
  has_many :users, through: :memberships
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :memberships, dependent: :destroy
end
