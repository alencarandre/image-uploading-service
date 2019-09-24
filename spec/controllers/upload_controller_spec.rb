require 'rails_helper'

RSpec.describe UploadController, type: :controller do
  describe '#create' do
    it 'upload images' do
      pintassilgo_file = File.join(Rails.root, '/spec/fixtures/images/pintassilgo.jpg')
      rouxinol_file = File.join(Rails.root, '/spec/fixtures/images/rouxinol.jpg')
      params = {
        owner: {
          name: 'Frank Sinatra',
          images_attributes: [{
            description: 'This is a pintassilgo',
            file: Rack::Test::UploadedFile.new(pintassilgo_file, 'image/jpeg', true)
          }, {
            description: 'This is a rouxinol',
            file: Rack::Test::UploadedFile.new(rouxinol_file, 'image/jpeg', true)
          }]
        }
      }

      post :create, params: params

      owner = JSON.parse(response.body)
      images = owner['images']

      expect(response.status).to eq(200)
      expect(images.count).to eq(2)
      expect(images.first.keys).to match_array(%w(description uploaded_at filename content_type url))
      expect(images.first).to include(
        'description' => 'This is a pintassilgo',
        'uploaded_at' => DateTime.now.strftime('%Y-%m-%d'),
        'filename' => 'pintassilgo.jpg',
        'content_type' => 'image/jpeg',
        'url' => a_string_including('pintassilgo.jpg')
      )
      expect(images.second).to include(
        'description' => 'This is a rouxinol',
        'uploaded_at' => DateTime.now.strftime('%Y-%m-%d'),
        'filename' => 'rouxinol.jpg',
        'content_type' => 'image/jpeg',
        'url' => a_string_including('rouxinol.jpg')
      )
    end

    it 'upload another image when owner already exists' do
      owner = FactoryBot.create(:owner)
      current_image = owner.images.first
      rouxinol_file = File.join(Rails.root, '/spec/fixtures/images/rouxinol.jpg')
      params = {
        owner: {
          name: owner.name,
          images_attributes: [{
            description: "This is a rouxinol, it's beautiful",
            file: Rack::Test::UploadedFile.new(rouxinol_file, 'image/jpeg', true)
          }]
        }
      }

      expect {
        post :create, params: params
      }.to change { owner.reload.images.count }
      .from(1)
      .to(2)

      owner = JSON.parse(response.body)
      images = owner['images']

      expect(response.status).to eq(200)
      expect(images.count).to eq(2)
      expect(images.first).to include(
        'description' => current_image.description,
        'uploaded_at' => current_image.file.created_at.strftime('%Y-%m-%d'),
        'filename' => current_image.file.filename.to_s,
        'content_type' => current_image.file.content_type,
        'url' => a_string_including(current_image.file.filename.to_s)
      )
      expect(images.second).to include(
        'description' => "This is a rouxinol, it's beautiful",
        'uploaded_at' => DateTime.now.strftime('%Y-%m-%d'),
        'filename' => 'rouxinol.jpg',
        'content_type' => 'image/jpeg',
        'url' => a_string_including('rouxinol.jpg')
      )
    end

    it 'returns error when not pass owner name' do
      pintassilgo_file = File.join(Rails.root, '/spec/fixtures/images/pintassilgo.jpg')
      params = {
        owner: {
          images_attributes: [{
            description: 'This is a pintassilgo',
            file: Rack::Test::UploadedFile.new(pintassilgo_file, 'image/jpeg', true)
          }]
        }
      }

      post :create, params: params

      data = JSON.parse(response.body)

      expect(response.status).to eq(400)
      expect(data['errors']).to include("Name can't be blank")
    end

    it 'returns error when not upload file' do
      params = {
        owner: {
          name: 'Batman',
          images_attributes: [{
            description: 'This is a pintassilgo'
          }]
        }
      }

      post :create, params: params

      data = JSON.parse(response.body)

      expect(response.status).to eq(400)
      expect(data['errors']).to include("Images file can't be blank")
    end
  end
end
