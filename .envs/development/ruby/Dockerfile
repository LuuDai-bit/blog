FROM ruby:3.3.7-bookworm

ARG USERID
ARG GROUPID
ARG APP_PATH=/blog

RUN apt-get update -qq && apt-get install -y build-essential \
postgresql-contrib \
libpq-dev \
postgresql-client \
imagemagick vim \
sudo \
cron \
systemd

RUN systemctl enable cron

RUN mkdir ${APP_PATH}
WORKDIR ${APP_PATH}

RUN gem install bundler -no-rdoc -no-ri
COPY Gemfile ${APP_PATH}/Gemfile
COPY Gemfile.lock ${APP_PATH}/Gemfile.lock
RUN bundle install -j 4

RUN rails action_text:install

# Map user outside to container user
RUN useradd -ms /bin/bash blog --no-log-init
RUN usermod -u ${USERID} blog
RUN groupmod -g ${GROUPID} blog || exit 0
RUN sudo echo "blog ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/blog
RUN sudo chown -R blog:blog ${APP_PATH}
USER blog
COPY --chown=blog:blog . .

EXPOSE 3000

# Configure the main process to run when running image
CMD ["bundle", "exec", "pumactl", "start"]
