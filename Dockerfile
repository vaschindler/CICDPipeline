# use a node base image
FROM node:12.0-slim

COPY package*.json ./

RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "main.js"]
