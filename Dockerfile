# Use Node.js runtime
FROM node:20.19.3

# Accept build-time environment variable
ARG VITE_API_BASE_URL

# Set working directory
WORKDIR /app

# Install npm globally
RUN npm install -g npm@10.8.2

# Copy package.json and lock file first to leverage cache
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app
COPY . .

# Set env for build
ENV VITE_API_BASE_URL=$VITE_API_BASE_URL

# Build frontend
RUN npm run build:fe

# Expose port
EXPOSE 5000

# Start frontend preview server
CMD ["npm", "run", "start:fe"]
