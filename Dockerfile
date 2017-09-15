FROM nginx:alpine
COPY public_html /usr/share/nginx/html
COPY conf /etc/nginx
