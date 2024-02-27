FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build 

FROM nginx:1.23.1-alpine
WORKDIR /usr/share/nginx/html
COPY --from=build /app/build .
ENTRYPOINT ["nginx", "-g", "daemon off;"]
