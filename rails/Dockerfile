FROM ruby:2.3.7-alpine3.7
MAINTAINER eng@awesomenesstv.com

RUN apk add --no-cache --update build-base \
                                linux-headers \
                                git \
                                postgresql-dev \
                                redis \
                                nodejs \
                                yarn \
                                tzdata

ENV APP_PATH /user/src/app/

WORKDIR $APP_PATH

COPY Gemfile* $APP_PATH

RUN bundle install --jobs \
    `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 3

COPY ./ $APP_PATH

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD rails server -p 3000
