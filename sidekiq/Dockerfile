FROM ruby:2.3-stretch

ENV APP_PATH /user/src/app/

ENV SERVER_ENVIRONMENT "development"
ENV NODE_ENV "development"
ENV RAILS_ENV "development"
ENV WEBPACKER_DEV_SERVER_HOST "0.0.0.0"

WORKDIR $APP_PATH

RUN apt-get update && apt-get install -qq -y build-essential bash sudo \
   libpq-dev postgresql-client python ruby-dev libc-dev git python libcurl4-openssl-dev \
   libffi-dev libxml2-dev libxslt-dev tzdata wget ca-certificates apt-transport-https \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

COPY package.json yarn.lock $APP_PATH

RUN apt-get update && \
    apt-get install -y yarn nodejs

COPY Gemfile* $APP_PATH

RUN bundle config build.patron --with-curl-config=`$(which curl-config)` \
    && bundle install --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1` --retry 5

COPY ./ $APP_PATH

EXPOSE 8081

ENTRYPOINT ["bundle", "exec"]

CMD sidekiq -p 8081 -q critical -q default
