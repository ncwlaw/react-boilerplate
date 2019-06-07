FROM node:8-slim

ARG USER_ID
ARG GROUP_ID

WORKDIR /home/www-data

COPY package.json ./
COPY package-lock.json ./

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    userdel -f www-data &&\
    if getent group www-data ; then groupdel www-data; fi &&\
    groupadd -g ${GROUP_ID} www-data &&\
    useradd -l -u ${USER_ID} -g www-data www-data &&\
    install -d -m 0755 -o www-data -g www-data /home/www-data &&\
    chown --changes --silent --no-dereference --recursive \
          --from=root:root ${USER_ID}:${GROUP_ID} \
        /home/www-data \
;fi

USER www-data

ENTRYPOINT npm run start
