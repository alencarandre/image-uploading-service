class ImageWithOwnerSerializer < ImageSerializer
  attributes :owner

  def owner
    object.owner.name
  end
end
