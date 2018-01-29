FROM ruby:2.4.3
RUN bundle config --global frozen 1
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN bundle install
COPY . /usr/src/app
CMD ["bundle","exec","rails","s","-b","0.0.0.0","-p","3000"]
