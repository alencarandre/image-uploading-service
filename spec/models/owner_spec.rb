require 'rails_helper'

RSpec.describe Owner, type: :model do
  subject { FactoryBot.create(:owner) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:owner)).to be_valid
  end

  context 'validations' do
    it 'validate name should be present' do
      should validate_presence_of(:name)
    end

    it 'validate unique index for name' do
      should validate_uniqueness_of(:name).case_insensitive
    end

    it 'returns true if allow images png, png and gif format' do
      expect(subject).to allow_content_types(Owner::MIMES_FOR_IMAGES).for(:images)
    end

    it 'returns false if attach unspected format' do
      all_mimes = Mime::EXTENSION_LOOKUP.map { |k, v| v.to_str }
      unpermitted_mimes = all_mimes - Owner::MIMES_FOR_IMAGES

      expect(subject).not_to allow_content_types(unpermitted_mimes).for(:images)
    end

    it 'returns false if has no image attachment' do
      subject.images.purge

      expect(subject).to_not be_valid
    end
  end
end
