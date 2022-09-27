class RehabVideo < ApplicationRecord
  has_one_attached :video
  has_one_attached :small_thumbnail
  has_one_attached :large_thumbnail
  has_one_attached :medium_thumbnail
  enum category: { exercise: 0, education: 1, recipe: 3 }

  validates_presence_of :category, :title
  validate :video_validation

  after_commit :save_thumbnails

  def video_validation
    if video.attached?
      if video.blob.byte_size > 200.megabytes
        video.purge
        errors[:base] << 'Too big'
      elsif !video.blob.content_type.starts_with?('video/')
        video.purge
        errors[:base] << 'Wrong format'
      end
    end
  end

  private

  def save_thumbnails
    return unless video.attached? && video.previewable?

    # we should do it in a background job but for this POC I excluded that complexity
    SaveThumbnails.call(rehab_video_id: id)
  end
end
