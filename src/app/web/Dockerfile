FROM node:20.10.0 as build-stage
WORKDIR /app

COPY . .
RUN npm i

RUN npm run build

ENV PORT=4000
EXPOSE 4000
CMD ["node", "build/index.js"]
