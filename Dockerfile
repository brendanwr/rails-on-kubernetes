FROM ruby:2.6.3

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install build-essential libpq-dev nodejs yarn -y

COPY Gemfile Gemfile.lock /tmp/
WORKDIR /tmp
RUN bundle install

RUN mkdir /app
WORKDIR /app
COPY . /app

RUN rails webpacker:install
