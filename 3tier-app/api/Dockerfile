# Use an official Node.js runtime as a base image
FROM node:18-alpine

# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json for dependency installation
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the api directory contents into the working directory
COPY . .

# Set environment variables (can be overridden during deployment)
ENV PORT=3000
ENV DB=example_db
ENV DBUSER=example_user
ENV DBPASS=example_pass
ENV DBHOST=localhost
ENV DBPORT=5432

# Expose the listening PORT
EXPOSE $PORT

# Add healthcheck to monitor container health
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:$PORT/health || exit 1

# Command to start the application
CMD ["npm", "start"]
