json.id video.id
json.title video.title
json.category video.category
video_content = video.video
if video_content.attached?
  json.video_url rails_blob_path(video_content, only_path: true) if video_content.attached?
  json.thumbnail_url rails_representation_url(video_content.preview(resize: '256x256'), only_path: true)
else
  json.video_url nil
  json.thumbnail_url nil
end
