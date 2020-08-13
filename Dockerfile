# use a node base image
FROM node:12.0-slim

COPY package*.json ./

HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://127.0.0.1:3000 || exit 1


RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "main.js"]
