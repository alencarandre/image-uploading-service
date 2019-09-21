FactoryBot.define do
  factory :owner do
    name { Faker::Name.unique.name }

    after :build do |owner|
      attachment = { io: StringIO.new('attachment'), filename: 'file.jpg', content_type: 'image/jpeg' }
      owner.images.attach(attachment)
    end
  end
end
