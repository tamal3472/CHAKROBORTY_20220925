FROM ruby:2.7.5-alpine AS base

RUN apk add --update --no-cache \
    ffmpeg \
    imagemagick \
    postgresql-dev \
    tzdata \
    nodejs \
    yarn

FROM base AS dependencies

RUN apk add --update --no-cache build-base

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs=3 --retry=3 --verbose

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

FROM base

WORKDIR /var/CHAKROBORTY20220925

COPY --from=dependencies /usr/local/bundle/ /usr/local/bundle/

COPY --from=dependencies /node_modules/ node_modules/

COPY . ./

RUN bundle exec rake assets:precompile

CMD bundle exec puma --config config/puma.rb
