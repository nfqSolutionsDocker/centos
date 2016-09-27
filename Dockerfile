FROM centos:7

MAINTAINER solutions@nfq.com

# Variables de entorno basicas
ENV TERM=xterm

# Intalacion paquetes
RUN yum -y install sudo epel-release && \
	yum -y install supervisor

# Creacion del usuario solutions en el grupo nfq
RUN groupadd nfq && \
	useradd -G root,nfq solutions && \
	echo "root:root" | chpasswd && \
	echo "solutions:solutions" | chpasswd && \
	echo "solutions ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
	echo "%nfq ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers && \
	sed -i "s/Defaults    requiretty/#Defaults    requiretty/g" /etc/sudoers

# Configuracion supervisor
COPY supervisord.conf /etc/supervisord.conf
RUN chmod -R 777 /var/log/supervisor

USER solutions

# Intalacion de otros paquetes
COPY install_packages.sh /home/solutions/
RUN chown solutions:nfq /home/solutions/install_packages.sh && \
	chmod 777 /home/solutions/install_packages.sh && \
	chmod a+x /home/solutions/install_packages.sh && \
	sed -i -e 's/\r$//' /home/solutions/install_packages.sh

CMD ["/usr/bin/supervisord"]