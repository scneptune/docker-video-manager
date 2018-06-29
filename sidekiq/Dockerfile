FROM ruby 2.3.7-alpine3.7
MAINTAINER eng@awesomenesstv.com

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                nodejs \
                                yarn \
                                tzdata

ENV SIDEKIQ_DIR
COPY Gemfile* ../rails
RUN bundle install --jobs \
    `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

ADD RAILS
