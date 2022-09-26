class SaveThumbnails
  LARGE_SIZE = '256x256'.freeze
  MEDIUM_SIZE = '128x128'.freeze
  SMALL_SIZE = '64x64'.freeze
  attr_reader :rehab_video, :rehab_video_id

  def self.call(rehab_video_id:)
    new(rehab_video_id: rehab_video_id).call
  end

  def initialize(rehab_video_id:)
    @rehab_video_id = rehab_video_id
    @rehab_video = RehabVideo.find(rehab_video_id)
  end

  def call
    rehab_video_content = rehab_video.video

    # We are skipping this callback to not to trigger this again and again for each thumbnail saving
    RehabVideo.skip_callback(:commit, :after, :save_thumbnails)
    save_small_thumbnail(rehab_video_content)
    save_medium_thumbnail(rehab_video_content)
    save_large_thumbnail(rehab_video_content)
    RehabVideo.set_callback(:commit, :after, :save_thumbnails)

  end

  private

  # saving happens here
  def save_small_thumbnail(video)
    file = small_size_thumbnail_file(video)
    begin
      rehab_video.small_thumbnail.attach(
        io: file,
        filename: "rehab_#{rehab_video_id}_small_thumbnail.jpg",
        content_type: 'image/jpg',
      )
    ensure
      #temp file are closed and deleted
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

  # thumb file gets created here
  def small_size_thumbnail_file(video)
    thumb = processed_video(video, SMALL_SIZE)
    File.open(write_in_temp_file(thumb), 'r')
  end

  def medium_size_thumbnail_file(video)
    thumb = processed_video(video, MEDIUM_SIZE)
    File.open(write_in_temp_file(thumb), 'r')
  end

  def large_size_thumbnail_file(video)
    thumb = processed_video(video, LARGE_SIZE)
    File.open(write_in_temp_file(thumb), 'r')
  end

  # Generating preview to save as thumb
  def processed_video(video, size)
    video.preview(resize: size)
  end

  def write_in_temp_file(thumb)
    # saving the generated thumb inside a temp file
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
