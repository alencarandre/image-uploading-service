class ImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :description, :uploaded_at, :filename, :content_type, :url

  def uploaded_at
    object.file.created_at.strftime('%Y-%m-%d')
  end

  def filename
    object.file.filename.to_s
  end

  def content_type
    object.file.content_type
  end

  def url
    rails_blob_url(object.file, disposition: 'attachment')
  end
end
