json.exercise @rehab_videos['exercise'] do |video|
    json.title video.title
    json.category video.category
end
json.education @rehab_videos['education'] do |video|
    json.title video.title
    json.category video.category
end
json.recipe @rehab_videos['recipe'] do |video|
    json.title video.title
    json.category video.category
end
