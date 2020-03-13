FROM node:latest
ARG repokey
RUN mkdir -p /usr/src/app
RUN npm install serve -g
WORKDIR /tmp
RUN git clone https://Trophalaxeur:${repokey}@framagit.org/Trophalaxeur/site-mariage.git
#GxKhna8qfSby9pTcYuRh
WORKDIR /tmp/site-mariage
RUN yarn install && yarn build
RUN cp build/* /usr/src/app -r
RUN rm -rf /tmp/site-mariage
WORKDIR /usr/src/app
RUN ls && pwd


CMD serve -s .

EXPOSE 5000