# Use an official Node.js runtime as a base image
FROM node:18-alpine

# Set working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files into the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the web directory contents into the working directory
COPY . .

# Set environment variables (can be overridden during deployment)
ENV PORT=3000
ENV API_HOST=http://api.node-app.local

# Expose the listening PORT
EXPOSE $PORT

# Command to start the application
CMD ["npm", "start"]

# Optional: Healthcheck to monitor the application
HEALTHCHECK --interval=30s --timeout=3s CMD curl -f http://localhost:$PORT/health || exit 1
