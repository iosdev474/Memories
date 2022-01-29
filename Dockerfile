# Stage 1 - the build process
FROM node:latest as build-deps
WORKDIR /app
COPY package.json ./
COPY . ./
RUN npm install
RUN npm run build

# Stage 2 - the production environment
FROM nginx:latest
COPY --from=build-deps /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]