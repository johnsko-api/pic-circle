class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle

  validates_format_of :image, :with => URI::regexp(%w(http https)), presence: true

end
