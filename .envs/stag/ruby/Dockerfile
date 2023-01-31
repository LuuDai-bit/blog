FROM ruby:3.0.0-slim-buster

RUN apt-get update -qq && apt-get install -y build-essential \
postgresql-contrib \
libpq-dev \
postgresql-client \
imagemagick vim\
sudo \
cron \
systemd

RUN systemctl enable cron

RUN mkdir /blog
WORKDIR /blog

RUN gem install bundler -no-rdoc -no-ri
COPY Gemfile /blog/Gemfile
COPY Gemfile.lock /blog/Gemfile.lock
RUN bundle install

# Install nodejs
RUN apt-get install -y curl
SHELL ["/bin/bash", "--login", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
RUN nvm install v14.16.0
RUN npm install --global yarn
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
