require 'rails_helper'

RSpec.describe RehabVideosController, type: :controller do
  let(:valid_attributes) do
    {
      title: 'Hello',
      video: Rack::Test::UploadedFile.new("#{Rails.root}/fixtures/sample_video.mp4", 'video/mp4'),
      category: 'education'
    }
  end

  let(:invalid_attributes) do
    {
      title: 'Hello',
    }
  end

  describe 'GET #index' do
    let!(:rehab_video1) { FactoryBot.create(:rehab_video, category: 'education') }
    let!(:rehab_video2) { FactoryBot.create(:rehab_video, category: 'recipe') }
    let!(:rehab_video3) { FactoryBot.create(:rehab_video, category: 'exercise') }
    render_views

    it 'returns response of json' do
      get :index, params: { format: :json }
      json_body = JSON.parse(response.body)
      expect(json_body['rehab_videos'].size).to eq(3)
      expect(json_body['rehab_videos']['recipe'].count).to eq(1)
      expect(json_body['rehab_videos']['education'].count).to eq(1)
      expect(json_body['rehab_videos']['exercise'].count).to eq(1)
      expect(json_body['video_upload_page_url']).to eq('/rehab_videos/new')
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Attachment' do
        expect do
          post :create, params: { rehab_video: valid_attributes }
        end.to change(RehabVideo, :count).by(1)
      end

      it 'assigns a newly created attachment as @attachment' do
        post :create, params: { rehab_video: valid_attributes }
        expect(JSON.parse(response.body)).to eq('error' => nil)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved attachment as @attachment' do
        post :create,params: { rehab_video: invalid_attributes }
        expect(JSON.parse(response.body)).to eq(
          'error' => {
            'category' => ["can't be blank"],
          },
        )
      end
    end
  end
end
