FROM nginx:alpine

COPY build/ /usr/share/nginx/html/

EXPOSE 84

CMD ["nginx", "-g", "daemon off;"]
