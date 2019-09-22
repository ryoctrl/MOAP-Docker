FROM node:10.16

USER root

ADD dummyfile /data/
RUN git clone --depth 1 https://git.mosin.jp/git/mosin/MOAP-Backend
WORKDIR MOAP-Backend
RUN npm install
EXPOSE 9250
ENTRYPOINT ["npm", "start"]