def save_attachment(rehab_video, title)
  # we are opening separate file for each video to avoid file read issue for active storage
  begin
    video_file = File.open("#{Rails.root}/fixtures/sample_video.mp4")
    rehab_video.video.attach(
      io: video_file, filename: "#{title}.mp4", content_type: 'video/mp4',
    )
  ensure
    # opened file gets closed
    video_file.close
  end
end

# Education videos
5.times do |iteration_number|
  title = "Education video #{iteration_number}"
  rehab_video = RehabVideo.create!(
    title: title,
    category: 'education',
  )
  save_attachment(rehab_video, title)
end

# Exercise Videos
5.times do |iteration_number|
  title = "Exercise video #{iteration_number}"
  rehab_video = RehabVideo.create!(
    title: title,
    category: 'exercise',
  )

  save_attachment(rehab_video, title)
end

# Recipe videos
5.times do |iteration_number|
  title = "Recipe video #{iteration_number}"
  rehab_video = RehabVideo.create!(
    title: title,
    category: 'recipe',
  )

  save_attachment(rehab_video, title)
end
