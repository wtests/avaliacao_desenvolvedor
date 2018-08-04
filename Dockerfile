FROM ruby:2.4.3
RUN apt-get update && \
  apt-get install nodejs sqlite -y && \
  gem install bundler && \
  gem install rails --no-ri --no-rdoc && \
  mkdir /app
WORKDIR app
EXPOSE 3000
COPY . /app
RUN bundle install
CMD bundle exec rails s -b 0.0.0.0 -p 3000
