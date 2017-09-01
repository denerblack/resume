FROM ruby:2.4
MAINTAINER Dener Carmo<dener.wilian@gmail.com>
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs mongodb git && gem install bundler --no-ri --no-rdoc
ENV APP_HOME /usr/resume
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile $APP_HOME/Gemfile
ADD Gemfile.lock $APP_HOME/Gemfile.lock
#RUN git clone https://github.com/denerblack/resume.git /resume/
#WORKDIR resume
#COPY Gemfile* ./
RUN bundle install
ADD . $APP_HOME
