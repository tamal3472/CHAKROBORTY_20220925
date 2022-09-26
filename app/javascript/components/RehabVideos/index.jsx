import axios from 'axios'
import React, { useEffect, useState, Fragment } from 'react'
import './style.scss'

const RehabVideos = () => {
  const [list, setList] = useState([]);
  const [newVideoUrl, setNewVideoUrl] = useState('');

  const fetchData = async() => {
     // the url should be in shared routes.js file skipped for this POC
      const { data } = await axios.get('http://localhost:3000/rehab_videos.json');

      setList(data.rehab_videos);
      setNewVideoUrl(data.video_upload_page_url);
  }

  const renderVideoList = video => (
    <div className="movie-card" key={video.id}>
      <div className="movie-card-header">
          <h2 className="top-movie-title">{video.title}</h2>
          <video className="movie" controls poster={video.thumbnail_url} >
            <source src={video.video_url} type="video/mp4"></source>
          </video>
      </div>
      <h2 className="movie-title">{video.title}</h2>
    </div>
  )

  useEffect(() => {
      fetchData()
  }, [])

  return (
    <Fragment>
      <button className="upload-page-button" onClick={()=> window.location.replace(newVideoUrl)} >Upload Video</button>
      <div className="category-page">
          <div className="category">
            <h1 className="category-title">Education</h1>
            <div className="movie-list">
              {
                list.education && list.education.map(video => renderVideoList(video))
              }
            </div>
          </div>

          <div className="category">
            <h1 className="category-title">Exercise</h1>
            <div className="movie-list">
              {
                list.exercise && list.exercise.map(video => renderVideoList(video))
              }
            </div>
          </div>

          <div className="category">
            <h1 className="category-title">Recipe</h1>
            <div className="movie-list">
              {
                list.recipe && list.recipe.map(video => renderVideoList(video))
              }
            </div>
          </div>
      </div>
    </Fragment>
  )
}

export default RehabVideos;
