class Owner < ApplicationRecord
  MIMES_FOR_IMAGES = %w(image/png image/jpg image/jpeg image/gif)
  has_many_attached :images

  validates :name, presence: true, uniqueness: true
  validate :validate_content_type
  validate :validate_has_attach

  private

  def validate_content_type
    return unless images.attached?

    images.each do |image|
      errors.add(:images, :content_type) && return unless image.content_type.in?(MIMES_FOR_IMAGES)
    end
  end

  def validate_has_attach
    errors.add(:images, :blank) unless images.attached?
  end
end
