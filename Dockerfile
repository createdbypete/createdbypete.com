FROM ruby
RUN apt-get update -qq && apt-get install -y nodejs
RUN gem install bundler
WORKDIR /src
COPY Gemfile* /src/
RUN bundle install
COPY . /src
