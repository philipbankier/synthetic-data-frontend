# Build stage
FROM node:alpine AS build
RUN apk add --no-cache build-base python3 linux-headers udev
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build

# Production stage
FROM node:alpine AS production
WORKDIR /app
COPY --from=build /app .
RUN npm install
CMD ["npm", "start"]
