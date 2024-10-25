# Use node base image for ARM64
FROM node:18-slim

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# Copy package.json and package-lock.json first for better caching
COPY package*.json ./

# Install dependencies
RUN npm install

# Bundle app source
COPY . .

# Create the public directory and ensure proper permissions
RUN mkdir -p public && chown -R node:node /usr/src/app

# Switch to non-root user
USER node

# Expose port
EXPOSE 3000

# Start the application
CMD [ "npm", "start" ]