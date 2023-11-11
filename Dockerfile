FROM ruby:3.2.2-slim-bookworm
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-mysql-client
RUN mkdir /app
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app/
