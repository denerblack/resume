FROM ruby:2.4
MAINTAINER Dener Carmo<dener.wilian@gmail.com>
ENV APP_HOME /usr/resume
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev mongodb git && gem install bundler --no-ri --no-rdoc && bundle install
#RUN git clone https://github.com/denerblack/resume.git /resume/
#WORKDIR resume
#COPY Gemfile* ./
#RUN bundle install
#ADD . /resume
