FactoryBot.define do
  factory :image do
    description { 'Image description' }

    after :build do |image|
      image.owner ||= FactoryBot.build(:owner, images: [image])
      unless image.file.attached?
        attachment = { io: StringIO.new('attachment'), filename: 'file.jpg', content_type: 'image/jpeg' }
        image.file.attach(attachment)
      end
    end
  end
end
