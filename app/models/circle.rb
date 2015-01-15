class Circle < ActiveRecord::Base
  has_many :users
  belongs_to :user
  has_many :comments
  has_many :pictures
end
