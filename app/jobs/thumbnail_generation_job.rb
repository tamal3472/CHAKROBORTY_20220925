class ThumbnailGenerationJob < ApplicationJob
  queue_as :default

  def perform(video_id)
      rehab_video = RehabVideo.find(video_id)
      SaveThumbnails.call(rehab_video: rehab_video)
  end
end
