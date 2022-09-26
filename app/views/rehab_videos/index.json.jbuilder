json.rehab_videos do
  json.exercise @rehab_videos['exercise'] do |video|
      json.partial! 'rehab_video', video: video
  end
  json.education @rehab_videos['education'] do |video|
      json.partial! 'rehab_video', video: video
  end
  json.recipe @rehab_videos['recipe'] do |video|
      json.partial! 'rehab_video', video: video
  end
end

json.video_upload_page_url new_rehab_video_path
