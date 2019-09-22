FactoryBot.define do
  factory :owner do
    name { Faker::Name.unique.name }

    after :build do |owner|
      owner.images << FactoryBot.build(:image) if owner.images.blank?
    end
  end
end
