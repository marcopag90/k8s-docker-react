FROM node:14-alpine as builder

WORKDIR '/app'

# Only package.json to install required dependencies
COPY package.json .
RUN npm install

# Now everything else and perform build
COPY . .
RUN npm run build

# Now build image from previous image layer, taking only the build result
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
