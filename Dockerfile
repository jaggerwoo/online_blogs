FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y debconf-utils autoconf bison vim build-essential curl git libffi-dev libncurses5-dev libpq-dev libreadline6-dev libssl-dev libyaml-dev imagemagick cron nodejs tzdata nginx yarn --no-install-recommends --fix-missing && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /home/app
ENV HOME /tmp
WORKDIR /home/app
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 20 --retry 5 --binstubs
COPY . ./
RUN bundle exec rake assets:precompile
# init system
# RUN bin/docker_init.sh
# setup shared volumes
# RUN rm -rf tmp log private public/system
RUN mkdir -p /home/app/tmp/pids
# need a /data volume
RUN ln -snf /data/log log && \
    ln -snf /data/public/system public/system

# port
EXPOSE 3000
ENTRYPOINT ["bundle", "exec"]
