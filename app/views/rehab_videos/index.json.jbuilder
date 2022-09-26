json.exercise @rehab_videos['exercise'] do |video|
    json.partial! 'rehab_video', video: video
end
json.education @rehab_videos['education'] do |video|
    json.partial! 'rehab_video', video: video
end
json.recipe @rehab_videos['recipe'] do |video|
    json.partial! 'rehab_video', video: video
end
