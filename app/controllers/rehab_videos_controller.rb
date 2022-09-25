class RehabVideosController < ApplicationController
    def index
      @rehab_videos = RehabVideo.all
    end

    def create
       rehab_video = RehabVideo.new(rehab_video_params)
      if rehab_video.save
        render json: { error: nil }
      else
        render json: { error: rehab_video.errors.messages },
               status: :unprocessable_entity
      end
    end

    private

    def rehab_video_params
      params.require(:rehab_video).permit(:title, :video, :category)
    end
end
