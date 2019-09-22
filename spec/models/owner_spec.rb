require 'rails_helper'

RSpec.describe Owner, type: :model do
  subject { FactoryBot.create(:owner) }

  it 'has a valid factory' do
    expect(FactoryBot.build(:owner)).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:images) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
