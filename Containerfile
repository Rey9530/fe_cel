FROM docker.io/nginx:1.25.3
COPY ./build/web /usr/share/nginx/app
# Set permissions for the copied directory
RUN chown -R nginx:nginx /usr/share/nginx/app
COPY nginx.conf /etc/nginx/conf.d/default.conf
ENV TZ="America/El_Salvador"
EXPOSE 80