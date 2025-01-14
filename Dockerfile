# Use the official Node.js image as a base
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
# test
COPY . .

# Expose the port the app runs on
EXPOSE 3000
#test

# Command to run the application
CMD ["node", "src/index.js"]
