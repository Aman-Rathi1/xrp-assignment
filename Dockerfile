FROM ubuntu:20.04
MAINTAINER rathiaman@gmail.com

RUN apt -y update
RUN apt -y install  apt-transport-https ca-certificates wget gnupg
RUN wget -q -O - "https://repos.ripple.com/repos/api/gpg/key/public" | apt-key add -
RUN echo "deb https://repos.ripple.com/repos/rippled-deb focal stable" >> /etc/apt/sources.list.d/ripple.list
RUN apt -y  update
RUN apt -y install rippled
RUN apt-get install libcap2-bin -y
RUN setcap 'cap_net_bind_service=+ep' /opt/ripple/bin/rippled
RUN ln -s /opt/ripple/etc/update-rippled-cron /etc/cron.d
COPY ripple/   /etc/opt/ripple
EXPOSE 51234 51235
CMD  ./opt/ripple/bin/rippled
