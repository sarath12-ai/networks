# Use the official Nginx image from Docker Hub
FROM nginx:alpine

# Copy HTML application files to the default Nginx HTML folder
COPY html /usr/share/nginx/html

# Expose port 80 to make the server accessible
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
