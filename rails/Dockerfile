FROM ruby:2.3.7-slim-stretch

ENV APP_PATH /usr/src/app/
ENV INIT_TASKS /usr/local/src

ENV SERVER_ENVIRONMENT "development"
ENV NODE_ENV "development"
ENV RAILS_ENV "development"
ENV WEBPACKER_DEV_SERVER_HOST "0.0.0.0"

WORKDIR $APP_PATH

RUN apt-get update && apt-get install -qq -y build-essential bash sudo \
   libpq-dev postgresql-client python ruby-dev libc-dev git curl python libcurl4-openssl-dev \
   libffi-dev libxml2-dev libxslt-dev tzdata wget ca-certificates apt-transport-https

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

ADD ["./package.json", "./yarn.lock"] $APP_PATH

RUN apt-get update && \
    apt-get install -y yarn nodejs

ADD ./ $APP_PATH

RUN bundle config build.patron --with-curl-config=`$(which curl-config)` \
    && bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 5

RUN apt-get clean && rm -rf /var/lib/apt/lists/* \
    && apt-get purge -y --auto-remove python git apt-transport-https build-essential

EXPOSE 3000

COPY ./docker-entrypoint.d $INIT_TASKS

WORKDIR $APP_PATH

ENTRYPOINT [$INIT_TASKS, 'init.sh']

CMD rails server -p 3000 -b 0.0.0.0
