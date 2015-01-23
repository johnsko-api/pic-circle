class Circle < ActiveRecord::Base
  has_many :users
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :memberships, dependent: :destroy

  validates :title, length: { maximum: 20 }, presence: true
  validates :description, presence: true
end
