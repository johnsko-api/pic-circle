class Picture < ActiveRecord::Base
  belongs_to :user
  belongs_to :circle

  has_attached_file :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/, presence: true
  validate :file_dimensions

private

  def file_dimensions(width = 200, height = 100)
    dimensions = Paperclip::Geometry.from_file(image.queued_for_write[:original].path)
    unless dimensions.width > width && dimensions.height > height
      errors.add :file, "image width must be #{width}px and height must be #{height}px"
    end
  end
end
