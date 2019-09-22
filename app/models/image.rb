class Image < ApplicationRecord
  MIMES_FOR_IMAGES = %w(image/png image/jpg image/jpeg image/gif)
  has_one_attached :file

  belongs_to :owner

  validates :owner, presence: true
  validate :validate_content_type
  validate :validate_has_attach

  private

  def validate_content_type
    return unless file.attached?

    errors.add(:file, :content_type) && return unless file.content_type.in?(MIMES_FOR_IMAGES)
  end

  def validate_has_attach
    errors.add(:file, :blank) unless file.attached?
  end
end
