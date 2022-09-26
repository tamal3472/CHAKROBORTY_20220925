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
        window.location.reload();
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
    if (file) {
      formData.append('rehab_video[video]', video);
    }
    formData.append('rehab_video[title]', title);
    formData.append('rehab_video[category]', category);

    submitToBackend(formData);
  };

  return (
    <Fragment>
      <div className="form-page category-page">
        <h1 className="title">Upload a movie</h1>
        <form onSubmit={submitHandler}>
          <div className="form-group">
            <label className="label">Title</label>
            <input
              className="input"
              type="text"
              value={title}
              onChange={evt => setTitle(evt.target.value)}
            />
             <div className="error">{error.title}</div>
          </div>

          <div className="form-group">
            <label className="label">Movie</label>
            <input
              type="file"
              id="file"
              onChange={event => setVideo(event.target.files[0])}
            />
            <div className="error">{error.video}</div>
          </div>

          <div className="form-group">
            <label className="label" htmlFor="videos">Category</label>
            <select className="select" id="videos" value={category} onChange={evt => setCategory(evt.target.value)}>
              <option selected hidden>Choose here</option>
              <option value="education">Education</option>
              <option value="exercise">Exercise</option>
              <option value="recipe">Recipe</option>
            </select>
            <div className="error">{error.category}</div>
          </div>

          <button className="button" type="submit">Submit</button>
        </form>
      </div>
    </Fragment>
  )
}

export default UploadRehabVideos;
