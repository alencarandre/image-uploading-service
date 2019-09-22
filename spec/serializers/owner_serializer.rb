require 'rails_helper'

RSpec.describe OwnerSerializer do
  it 'serializer object' do
    owner = FactoryBot.create(:owner)
    image = owner.images.first
    serializer = described_class.new(owner)

    expect(serializer.to_h).to include(
      name: owner.name,
      images: [{
        description: image.description,
        uploaded_at: image.file.created_at.strftime('%Y-%m-%d'),
        filename: image.file.filename.to_s,
        content_type: image.file.content_type,
        url: a_string_including(image.file.filename.to_s)
      }]
    )
  end
end
