# README

## To setup without docker your local system needs you need to have

* Ruby version
```bash
 ruby '2.7.5'
```

* Node version
```bash
  node '12.18.2'
```

* Rails version
```bash
 gem 'rails', '~> 6.1.x'
```

* Database
```bash
 latest postgres
```

** To run the project

- Clone the repository

  ```bash
    https://github.com/tamal3472/CHAKROBORTY_20220925.git
  ```

- Run command

  ```bash
    gem install bundler 2.3.8
    bundle install
    yarn install
    rails db:create
    rails db:migrate
    rails db:seed
    rails s
    bin/webpack-dev-server
  ```
Server is now up and running at: http://localhost:3000

## To setup with docker follow this
- Clone the repository

  ```bash
    https://github.com/tamal3472/CHAKROBORTY_20220925.git
  ```

- Run command

  ```bash
  docker-compose up --build
  docker-compose run web rails db:create
  docker-compose run web rails db:migrate
  docker-compose run web rails db:seed
  ```
Server is now up and running at: http://localhost:3000

## **API Documentation**

- Retrieve
 ```bash
  GET  localhost:3000/rehab_videos.json
```
The expected response will be
 ```bash
   {
      "rehab_videos": {
        "education": [
          {
            "category": "education",
            "title": "Education video 1"
            "video_url": "/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdDVG9JYTJWk",
            "thumbnail_url": "/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdDVG9JYTJWNVNTSWhi",
          }
          ...
        ]
        "exercise": [
          {
            "category": "exercise",
            "title": "Exercise video 1",
            "video_url": "/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdDVGk",
            "thumbnail_url": "/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdDVGSFpwWk",
          }
          ...
        ]
        "recipe": [
          {
            "category": "recipe",
            "title": "Recipe video 1",
            "video_url": "/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdDVGk",
            "thumbnail_url": "/rails/active_storage/disk/eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaDdDVGSFpwWk",
          }
          ...
        ]
      },
      "video_upload_page_url": "/rehab_videos/new"
    }
```


- Upload a rehab video with valid params
 ```bash
params: {
  *title* -> string, required
  *category* -> string, required
  *video* -> video file(i.e. .mp4)
}

  POST  localhost:3000/rehab_videos/new
```
The expected response for valid params
 ```bash
{
  "error": nil
}
```

The expected response for invalid params
 ```bash
 Respose status: 422
{
  "error": { "category": "can't be blank" }
}
```

## Frontend POC

