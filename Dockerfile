FROM node:8.9.1-alpine
MAINTAINER Jeremy Toussaint <jeremy.toussaint@telia.no>

# Expose port
EXPOSE 33333

#Install PM2 globally
RUN npm install pm2 -g

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Copy all project to working directory
COPY . /usr/src/app
# Set production env variables for npm install
ENV NODE_ENV production
# Get packages, and build react distribution folder
RUN npm install

# Docker runtime business - does not execute during build
CMD ["pm2-docker", "index.js"]