import axios from 'axios'
import React, { useState, Fragment } from 'react'
import './style.scss'

const UploadRehabVideos = () => {
  const [title, setTitle] = useState('');
  const [video, setVideo] = useState(null);
  const [category, setCategory] = useState('');
  const [error, setError] = useState('');

  const submitToBackend = async formData => {
    try {
      const { data } = await axios.post(
        'http://localhost:3000/rehab_videos', formData
      );
      if (data.error === null) {
        window.location.replace('http://localhost:3000/rehab_videos');
      }
    } catch (exception) {
      const { response } = exception;
      if (response.status === 422) {
        setError(response.data.error);
      }
    }
  };

  const submitHandler = async(event) => {
    event.preventDefault();
    setError({});
    const formData = new FormData();
    if (video) {
      formData.append('rehab_video[video]', video);
    }
    formData.append('rehab_video[title]', title);
    formData.append('rehab_video[category]', category);

    submitToBackend(formData);
  };

  return (
    <Fragment>
      <div className="form-page content-page">
        <h1 className="form-page__title">Upload a video</h1>
        <form onSubmit={submitHandler}>
          <div className="form-page__form-group">
            <label className="form-page__form-group-label">Title</label>
            <input
              className="input"
              type="text"
              value={title}
              onChange={evt => setTitle(evt.target.value)}
            />
             <div className="form-page__form-group-error">{error.title}</div>
          </div>

          <div className="form-page__form-group">
            <label className="form-page__form-group-label">Movie</label>
            <input
              type="file"
              id="file"
              onChange={event => setVideo(event.target.files[0])}
            />
            <div className="form-page__form-group-error">{error.video}</div>
          </div>

          <div className="form-page__form-group">
            <label className="form-page__form-group-label" htmlFor="videos">Category</label>
            <select className="form-page__form-group-select" id="videos" value={category} onChange={evt => setCategory(evt.target.value)}>
              <option selected hidden>Choose here</option>
              <option value="education">Education</option>
              <option value="exercise">Exercise</option>
              <option value="recipe">Recipe</option>
            </select>
            <div className="form-page__form-group-error">{error.category}</div>
          </div>

          <button className="form-page__button" type="submit">Submit</button>
        </form>
      </div>
    </Fragment>
  )
}

export default UploadRehabVideos;
