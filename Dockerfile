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
FROM node:10-slimasbuild-step
RUN mkdir-p/app

WORKDIR /app

COPY package.json /app
#ENVNODE_OPTIONS=--max-old-space-size=900

RUN npmconfigsetstrict-sslfalse
RUN npmconfigsetregistryhttp://registry.npmjs.org/
RUN npminstall
COPY . /app
RUN npmrunbuild--prod
#RUN cp -r ./dist/frontend/. /usr/share/nginx/html
COPY --from=build-step /app/dist/angular-tour-of-heroes /usr/share/nginx/html
#Segunda Etapa
FROM nginxinc/nginx-unprivileged
USER root
RUN echo$NODE_ENV
RUN chgrp-Rroot/var/cache/nginx/var/run/var/log/nginx&&\
chmod-R770/var/cache/nginx/var/run/var/log/nginx
