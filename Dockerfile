# FROM node:10-alpine as build-step

# RUN mkdir -p /app

# WORKDIR /app

# COPY package.json /app

# RUN npm install


# COPY . /app

# RUN npm run build --prod


# FROM nginx:1.17.1-alpine

# COPY --from=build-step /app/dist/angular-tour-of-heroes /usr/share/nginx/html



    #------------------ DOCKER CONFIGURATION 2 ------------------ 
#Primera Etapa
FROM node:slim as build-step
RUN mkdir -p /app

WORKDIR /app

COPY package.json /app
#ENVNODE_OPTIONS=--max-old-space-size=900

RUN npm config set strict-ssl false
RUN npm config set registry http://registry.npmjs.org/
RUN npm install
COPY . /app
RUN npm run build --prod
#RUN cp -r ./dist/angular-tour-of-heroes/. /usr/share/nginx/html

#Segunda Etapa
FROM nginxinc/nginx-unprivileged
USER root
COPY --from=build-step /app/dist/angular-tour-of-heroes /usr/share/nginx/html
# RUN chgrp -R root /var/cache/nginx/var/run/var/log/nginx &&\
# chmod -R 770 /var/cache/nginx/var/run/var/log/nginx
