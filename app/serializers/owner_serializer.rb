class OwnerSerializer < ActiveModel::Serializer
  attributes :name, :images

  has_many :images
end
