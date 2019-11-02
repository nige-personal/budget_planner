FROM ruby:2.5.1-alpine

RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake bash \
    ruby-bigdecimal ruby-io-console libstdc++ tzdata postgresql-client nodejs

COPY Gemfile Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies build-base ruby-dev \
    postgresql-dev libc-dev linux-headers && \
    gem install bundler && \
    cd /app; bundle install && \
    apk del build-dependencies

COPY . /app/
WORKDIR /app
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]