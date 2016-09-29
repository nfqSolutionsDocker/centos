FROM centos:7

MAINTAINER solutions@nfq.com

# Variables de entorno basicas
ENV TERM=xterm

# Intalacion paquetes
RUN yum -y install sudo epel-release && \
	yum -y install supervisor

# Modificaciones usuario root
COPY banner.txt /tmp
RUN echo "root:root" | chpasswd && \
	sed -i "s/Defaults    requiretty/#Defaults    requiretty/g" /etc/sudoers && \
	ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime && \
	cat /tmp/banner.txt >> /etc/profile 

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf
RUN chmod -R 777 /var/log/supervisor

# Intalacion de otros paquetes
COPY install_packages.sh /home/solutions/
RUN chmod 777 /home/solutions/install_packages.sh && \
	chmod a+x /home/solutions/install_packages.sh && \
	sed -i -e 's/\r$//' /home/solutions/install_packages.sh

CMD ["/usr/bin/supervisord"]