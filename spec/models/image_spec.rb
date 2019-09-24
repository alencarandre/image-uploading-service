require 'rails_helper'

RSpec.describe Image, type: :model do
  subject { FactoryBot.create(:image) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:owner)).to be_valid
  end

  context 'validations' do
    it 'validate description limit' do
      should validate_length_of(:description).is_at_most(255)
    end

    it 'returns true if allow images png, png and gif format' do
      expect(subject).to allow_content_types(Image::MIMES_FOR_IMAGES).for(:file)
    end

    it 'returns false if attach unspected format' do
      all_mimes = Mime::EXTENSION_LOOKUP.map { |k, v| v.to_str }
      unpermitted_mimes = all_mimes - Image::MIMES_FOR_IMAGES

      expect(subject).not_to allow_content_types(unpermitted_mimes).for(:file)
    end

    it 'returns false if has no image attachment' do
      subject.file.purge

      expect(subject).to_not be_valid
    end
  end
end
