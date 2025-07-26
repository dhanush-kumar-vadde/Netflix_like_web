FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -f index.html
COPY index.html .
EXPOSE 8888


