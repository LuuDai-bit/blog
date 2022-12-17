FROM ruby:3.1.2-slim-buster

RUN apt-get update -qq && apt-get install -y build-essential postgresql-contrib libpq-dev postgresql-client

RUN mkdir /simple-blog
WORKDIR /simple-blog

RUN gem install bundler -no-rdoc -no-ri
COPY Gemfile /simple-blog/Gemfile
COPY Gemfile.lock /simple-blog/Gemfile.lock
RUN bundle install -j 4

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running image
CMD ["bundle", "exec", "pumactl", "start"]
