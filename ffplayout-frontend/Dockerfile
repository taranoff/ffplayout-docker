FROM node:lts-alpine AS build-stage

ENV NUXT_TELEMETRY_DISABLED=1
ARG version=3.0.1

# get ffplayout-api and all dependencies
RUN apk update && \
    apk add --no-cache tzdata && \
    cd /opt && \
    wget "https://github.com/ffplayout/ffplayout-frontend/archive/v${version}.zip" && \
    unzip "v${version}.zip" && \
    mv "ffplayout-frontend-${version}" 'ffplayout-frontend' && \
    rm "v${version}.zip" && \
    cd ffplayout-frontend && \
    echo "BASE_URL='http://localhost'" > .env && \
    echo "API_URL='/'" >> .env && \
    npm install && \
    npm run build && \
    rm -rf node_modules

FROM nginx:stable-alpine AS production-stage
COPY --from=build-stage /opt/ffplayout-frontend/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
