FROM ruby:3.3.11-slim

COPY --from=node:24-slim /usr/local/bin /usr/local/bin
COPY --from=node:24-slim /usr/local/lib /usr/local/lib

RUN apt-get update -qq && apt-get install -y build-essential \
postgresql-contrib \
libpq-dev \
postgresql-client \
imagemagick vim \
sudo \
cron \
systemd \
libvips-dev \
libyaml-dev

RUN systemctl enable cron

RUN mkdir /blog
WORKDIR /blog

RUN gem install bundler -v 2.5.9 -no-rdoc -no-ri
COPY Gemfile /blog/Gemfile
COPY Gemfile.lock /blog/Gemfile.lock
RUN bundle install

# Install nodejs
COPY --from=node:24-slim /opt /opt
RUN node -v && npm -v && yarn -v
RUN yarn
SHELL ["/bin/sh", "-c"]
RUN rails action_text:install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running image
CMD ["bundle", "exec", "pumactl", "start"]
