FROM node:alpine as builder

RUN addgroup app && adduser -S -G app app
RUN mkdir /usr/app && chown app:app /usr/app
USER app

WORKDIR '/usr/app'

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /usr/app/build /usr/share/nginx/html