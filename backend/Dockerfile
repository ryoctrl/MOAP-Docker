FROM node:10.16

USER root

RUN git clone https://git.mosin.jp/git/mosin/MOAP-Backend.git
WORKDIR MOAP-Backend
RUN npm install
EXPOSE 9250
ENTRYPOINT ["npm", "start"]
