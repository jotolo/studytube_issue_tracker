FROM ruby:2.5.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs imagemagick
RUN mkdir -p /studytube
WORKDIR /studytube
ENV APP_DIR /studytube

ADD Gemfile /studytube/Gemfile
ADD Gemfile.lock /studytube/Gemfile.lock
ADD . /studytube

RUN gem install bundler
RUN bundle check || bundle install -j 4

# Make port 3000 available to the world outside this container
EXPOSE 3000

# Define environment variable
#ENV NAME World

### Helpers:
# Remove all containers:
# $ docker rm $(docker ps -qa)
# Remove all untagged images:
# $ docker rmi -f $(docker images | grep '^<none>' | awk '{print $3}')
###

CMD ["bash", "-c", "rake db:create; rake db:migrate; rake db:seed; rails s -p 3000 -b '0.0.0.0'"]