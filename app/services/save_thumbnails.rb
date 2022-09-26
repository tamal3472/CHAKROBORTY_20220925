class SaveThumbnails
  attr_reader :rehab_video

  def self.call(rehab_video:)
    new(rehab_video: rehab_video).call
  end

  def initialize(rehab_video:)
    @rehab_video = rehab_video
  end

  def call
    rehab_video_content = rehab_video.video
    RehabVideo.skip_callback(:save, :after, :save_thumbnails)
    save_small_thumbnail(rehab_video_content)
    save_medium_thumbnail(rehab_video_content)
    save_large_thumbnail(rehab_video_content)
    RehabVideo.set_callback(:save, :after, :save_thumbnails)
  end

  private

  def save_small_thumbnail(video)
    file = small_size_thumbnail_file(video)
    begin
      rehab_video.small_thumbnail.attach(
        io: file,
        filename: "rehab_#{rehab_video_id}_small_thumbnail.jpg",
        content_type: 'image/jpg',
      )
    ensure
      file.close
      File.delete(file.path)
    end
  end

  def save_medium_thumbnail(video)
    file = medium_size_thumbnail_file(video)
    begin
      rehab_video.medium_thumbnail.attach(
        io: file,
        filename: "rehab_#{rehab_video_id}_medium_thumbnail.jpg",
        content_type: 'image/jpg',
      )
    ensure
      file.close
      File.delete(file.path)
    end
  end

  def save_large_thumbnail(video)
    file = large_size_thumbnail_file(video)
    begin
      rehab_video.large_thumbnail.attach(
        io: file,
        filename: "rehab_#{rehab_video_id}_large_thumbnail.jpg",
        content_type: 'image/jpg',
      )
    ensure
      file.close
      File.delete(file.path)
    end
  end

  def small_size_thumbnail_file(video)
    thumb = processed_video(video, '64x64')
    File.open(write_in_temp_file(thumb), 'r')
  end

  def medium_size_thumbnail_file(video)
    thumb = processed_video(video, '128x128')
    File.open(write_in_temp_file(thumb), 'r')
  end

  def large_size_thumbnail_file(video)
    thumb = processed_video(video, '256x256')
    File.open(write_in_temp_file(thumb), 'r')
  end

  def processed_video(video, size)
    video.preview(resize: size)
  end

  def rehab_video_id
    @rehab_video_id ||= rehab_video.id
  end

  def write_in_temp_file(thumb)
    opened_tempfile = File.open(temp_file_path, 'wb')
    opened_tempfile.binmode
    opened_tempfile.write(thumb)
    opened_tempfile.rewind

    opened_tempfile.path
  end

  def temp_file_path
    Tempfile.new.path
  end
end
