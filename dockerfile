FROM debian:stretch
MAINTAINER Brice RENAND <brice.renand@ecole-isitech.fr>

RUN apt-get update
RUN apt-get -y -q install curl
RUN curl -s --remote-name http://apt.ntop.org/stretch/all/apt-ntop.deb
RUN apt install ./apt-ntop.deb
RUN rm -rf apt-ntop.deb

RUN apt-get update
RUN apt-get -y -q install ntopng redis-server libpcap0.8 libmysqlclient18

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 3000

RUN echo '#!/bin/bash\n/etc/init.d/redis-server start\nntopng "$@"' > /tmp/run.sh
RUN chmod +x /tmp/run.sh

ENTRYPOINT ["/tmp/run.sh"]