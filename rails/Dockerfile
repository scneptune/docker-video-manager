FROM ruby:2.3.7-slim-stretch


ARG NO_DUMP_RESTORE
ENV NO_DUMP_RESTORE=$NO_DUMP_RESTORE

ENV APP_PATH /usr/src/app
ENV ENTRYPOINT_TASKS /usr/local/scripts

ENV SERVER_ENVIRONMENT "development"
ENV NODE_ENV "development"
ENV RAILS_ENV "development"
ENV WEBPACKER_DEV_SERVER_HOST "0.0.0.0"
# this seems silly but its because of the way that rails parses env's in yaml for docker
ENV ALGOLIA_SUFFIX 'stephen'

WORKDIR $ENTRYPOINT_TASKS

ADD ./rails/docker-entrypoint.d $ENTRYPOINT_TASKS

RUN chmod +x $ENTRYPOINT_TASKS/*

WORKDIR $APP_PATH

RUN apt-get update && apt-get install -qq -y build-essential bash sudo \
   libpq-dev postgresql-client netcat python ruby-dev libc-dev git curl python libcurl4-openssl-dev \
   libffi-dev libxml2-dev libxslt-dev tzdata wget ca-certificates apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

COPY ./video-manager/package.json $APP_PATH
COPY ./video-manager/yarn.lock $APP_PATH

RUN apt-get update && \
    apt-get install -y yarn nodejs

ADD ./video-manager $APP_PATH

RUN bundle config build.patron --with-curl-config=`$(which curl-config)` \
    && bundle install --jobs=`expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry=5

RUN yarn install && bundle exec ./bin/webpack

RUN apt-get clean && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove python git apt-transport-https build-essential

EXPOSE 3000

ENTRYPOINT ["sh", "/usr/local/scripts/init.sh"]
