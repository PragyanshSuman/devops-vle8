FROM nginx:latest
RUN echo "Hello from Blue Environment (v1)" > /usr/share/nginx/html/index.html
