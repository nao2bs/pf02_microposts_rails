FROM ruby:2.4.1
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs less -y --force-yes
#RUN apt-get install debian-keyring debian-archive-keyring -y --force-yes
#RUN apt-get update -qq && apt-get install -y nodejs

ENV APP_HOME /usr/src/app

RUN mkdir $APP_HOME
WORKDIR $APP_HOME

COPY Gemfile $APP_HOME/Gemfile
COPY Gemfile.lock $APP_HOME/Gemfile.lock

RUN gem install bundler -v 1.17.3
RUN bundle install

