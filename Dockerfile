# Build the app
FROM node:22-alpine As build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Serve the app with only the build files
FROM node:22-alpine
WORKDIR /app
COPY --from=build /app/build ./build
RUN npm install -g serve

EXPOSE 3000

CMD ["serve", "-s", "build", "-l", "3000"] 