FROM node:lts as init

COPY package.json package-lock.json /src/
WORKDIR /src
RUN npm ci
COPY img /src/img
COPY *.md /src/

FROM node:lts as deck_build
ARG URL
WORKDIR /src
COPY --from=init /src/ /src/
COPY reveal-deck.json /src/reveal.json
RUN npm run r:build -- ./ --static _deck --absolute-url https://${URL}

FROM node:lts as slides_build
ARG URL
WORKDIR /src
COPY --from=init /src/ /src/
COPY reveal-slides.json /src/reveal.json
RUN npm run r:build -- ./ --static _slides --absolute-url https://${URL}

FROM nginx:latest as deck
COPY --from=deck_build /src/_deck /usr/share/nginx/html
COPY --from=init /src/img /usr/share/nginx/html/img

FROM nginx:latest as slides
COPY --from=slides_build /src/_slides /usr/share/nginx/html
COPY --from=init /src/img /usr/share/nginx/html/img