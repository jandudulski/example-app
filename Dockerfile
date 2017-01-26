FROM alpine:3.5
MAINTAINER Jan Dudulski <jan@dudulski.pl>

ENV PORT 80

RUN apk -U upgrade
RUN apk add curl wget bash build-base
RUN apk add ruby ruby-bundler ruby-dev ruby-json

RUN mkdir -p /opt/app
WORKDIR /opt/app

COPY Gemfile* ./

RUN bundle --deployment --without development

COPY . .

# Cleanup
RUN rm -rf /var/cache/apk/*

EXPOSE $PORT
CMD ["/opt/app/bin/puma", "-C", "./config/puma.rb"]
