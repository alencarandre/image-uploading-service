require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  it 'list all uploaded images' do
    image1 = FactoryBot.create(:image, description: 'Image 1')
    image2 = FactoryBot.create(:image, description: 'Image 2')

    post :index

    images = JSON.parse(response.body)

    expect(images.count).to eq(2)
    expect(images.first).to include(
      'owner' => image1.owner.name,
      'description' => image1.description,
      'uploaded_at' => image1.file.created_at.strftime('%Y-%m-%d'),
      'filename' => image1.file.filename.to_s,
      'content_type' => image1.file.content_type,
      'url' => a_string_including(image1.file.filename.to_s)
    )
    expect(images.second).to include(
      'owner' => image2.owner.name,
      'description' => image2.description,
      'uploaded_at' => image2.file.created_at.strftime('%Y-%m-%d'),
      'filename' => image2.file.filename.to_s,
      'content_type' => image2.file.content_type,
      'url' => a_string_including(image2.file.filename.to_s)
    )
  end
end
