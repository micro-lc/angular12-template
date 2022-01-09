FROM nginx:1.18.0-alpine as build

LABEL name="microlc-angular-template" \
  description="This template showcases how to start setting up a micro-lc plugin project with navigation and the Angular framework" \
  eu.mia-platform.url="https://www.mia-platform.eu" \
  eu.mia-platform.version="0.1.0"

COPY nginx /etc/nginx

RUN touch ./off \
  && chmod o+rw ./off \
  && echo "microlc-angular-template: $COMMIT_SHA" >> /etc/nginx/commit.sha

WORKDIR /usr/static

COPY ./dist .

USER nginx
