FROM ruby:3.0-alpine3.12

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

RUN apk add --no-cache bash alpine-sdk libffi-dev && \
bundle install --system --without development test
ADD . /app
RUN cp config/cerberus.yml.example config/cerberus.yml

EXPOSE 3000

CMD ["bundle", "exec", "rackup", "config.ru", "-p", "3000" ,"-o", "0.0.0.0"]
