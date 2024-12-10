# Use a base image with Flutter installed
FROM cirrusci/flutter:3.5.4

# Set working directory
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Install dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Use a lightweight web server to serve the build output
FROM nginx:alpine
COPY --from=0 /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start the web server
CMD ["nginx", "-g", "daemon off;"]
