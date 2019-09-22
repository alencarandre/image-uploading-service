class Owner < ApplicationRecord
  has_many :images, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :images, presence: true

  accepts_nested_attributes_for :images,
    allow_destroy: true,
    reject_if: :all_blank
end
