# Use a lightweight Node.js image
FROM node:18-slim

# Set working directory
WORKDIR /app

# Install required system dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy project files
COPY . .

# Create session directory with full permissions
RUN mkdir -p session && chmod -R 777 session

# Expose the port (if needed for a web server)
EXPOSE 3000  

# Start the bot without readline issue
CMD ["node", "index.js"]