FROM nginx:1.17.9

# Set default argument variables
ARG APP_PATH=/app
ARG BASIC_AUTH_USERNAME
ARG BASIC_AUTH_PASSWORD
ARG DOMAIN_WEB

# Binding argument variables to environment variables
ENV APP_PATH=${APP_PATH}
ENV DOMAIN_WEB=${DOMAIN_WEB}

# Install dependencies
RUN apt-get update && \
    apt-get -y install vim curl openssl --no-install-recommends apt-utils apache2-utils && \
    rm -r /var/lib/apt/lists/*

# Set our working directory inside the image
WORKDIR ${APP_PATH}

# Create log directory
RUN mkdir -p log

# Create cert directory
RUN mkdir -p /etc/nginx/certs

# Copy all command scripts
COPY nginx/*.sh /scripts/
COPY common/wait-for-it.sh /scripts/

# Create ssl certification directory
RUN mkdir -p /etc/nginx/ssl/codedehoc_site/

# Copy certification and private key to directory
COPY ssl/* /etc/nginx/ssl/codedehoc_site/

# Grant script execute permission
RUN chmod a+x /scripts/*.sh

# Copy Nginx config template
COPY nginx/*.conf /tmp/

# Generate config file from variable references in the Nginx config template
RUN envsubst '${APP_PATH} ${DOMAIN_WEB}' < /tmp/default.conf > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["/scripts/command.sh"]
