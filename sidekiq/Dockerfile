FROM ruby:2.3.7-alpine3.7
MAINTAINER eng@awesomenesstv.com

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                libcurl \
                                postgresql-dev \
                                redis \
                                nodejs \
                                yarn \
                                tzdata

RUN apk add --no-cache curl

ENV APP_PATH /user/src/app/

ENV CURLINSTALLPATH which curl

WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH

# RUN bundle config build.patron --with-curl-config=/usr/local/opt/curl/bin/curl-config

# RUN bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 5
#
COPY ./ $APP_PATH
#
EXPOSE 8081
#
ENTRYPOINT ["bundle", "exec"]
#
# CMD sidekiq -p 8081 -q critical -q default
