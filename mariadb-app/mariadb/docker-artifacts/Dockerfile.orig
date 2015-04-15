FROM fedora
MAINTAINER Stephen Tweedie <sct@redhat.com>
RUN yum -y update
RUN yum -y install mariadb-server pwgen supervisor psmisc net-tools 
RUN yum clean all

ADD ./start.sh /start.sh
ADD ./config_mariadb.sh /config_mariadb.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /start.sh
RUN chmod 755 /config_mariadb.sh
RUN /config_mariadb.sh

EXPOSE 3306

CMD ["/bin/bash", "/start.sh"]
