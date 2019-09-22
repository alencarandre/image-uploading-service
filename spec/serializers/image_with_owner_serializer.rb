require 'rails_helper'

RSpec.describe ImageSerializer do
  it 'serializer object' do
    image = FactoryBot.create(:image)
    serializer = described_class.new(image)

    expect(serializer.to_h).to include(
      owner: image.owner.name,
      description: image.description,
      uploaded_at: image.file.created_at.strftime('%Y-%m-%d'),
      filename: image.file.filename.to_s,
      content_type: image.file.content_type,
      url: a_string_including(image.file.filename.to_s)
    )
  end
end
