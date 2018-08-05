FROM ruby:2.4.3
RUN apt-get update && \
  apt-get install nodejs sqlite unzip -y && \
  gem install bundler && \
  gem install rails --no-ri --no-rdoc && \
  mkdir /app
RUN curl -fsSl https://gist.githubusercontent.com/nathanpsouza/41c6a6c49336dd19485e5eb03c6e4868/raw/32404adab8e3946a6bc08d8d9ccb36eb8bc9c0a9/install_phantomjs.sh | bash

WORKDIR app
EXPOSE 3000
COPY . /app
RUN bundle install
CMD bundle exec rails s -b 0.0.0.0 -p 3000
