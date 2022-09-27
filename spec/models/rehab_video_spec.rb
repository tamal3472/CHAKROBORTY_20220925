require 'rails_helper'

RSpec.describe RehabVideo, type: :model do
  let(:rehab_video) { FactoryBot.create(:rehab_video) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :category }
  it { is_expected.to define_enum_for(:category).with_values(exercise: 0, education: 1, recipe: 3) }

  describe '#save_thumbnails' do
    let!(:rehab_video_create) { FactoryBot.create(:rehab_video) }
    it 'generates thumnails' do
      expect(rehab_video_create.small_thumbnail.attached?).to be_truthy
      expect(rehab_video_create.medium_thumbnail.attached?).to be_truthy
      expect(rehab_video_create.large_thumbnail.attached?).to be_truthy
    end
  end
end
