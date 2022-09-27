FactoryBot.define do
  factory :rehab_video do
    title { 'Education video 01' }
    category { 'education'}


    after(:build) do |rehab_video|
        file = File.open("#{Rails.root}/fixtures/sample_video.mp4")
        rehab_video.video.attach(
          io: file,
          filename: 'test_video.mp4',
          content_type: 'video/mp4'
        )
    end
  end
end
