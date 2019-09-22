FROM ruby:2.6.4

RUN apt-get update && apt-get install -y postgresql-client

ADD . /app/image-uploading-services

WORKDIR /app/image-uploading-services

RUN bundle install --without development test

EXPOSE 3000

CMD bash bin/start
