FROM centos:7

MAINTAINER solutions@nfq.com

# Intalacion paquetes
RUN yum -y install sudo

# Creacion del usuario solutions en el grupo nfq
RUN groupadd nfq
RUN useradd -g nfq solutions
RUN echo "root:Abc123$" | chpasswd
RUN echo "solutions:Abc123$" | chpasswd
RUN echo "solutions ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN echo "%nfq ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN sed -i "s/Defaults    requiretty/#Defaults    requiretty/g" /etc/sudoers

USER solutions

# Intalacion de otros paquetes
COPY install_packages.sh /home/solutions/
RUN sudo chown solutions:nfq /home/solutions/install_packages.sh
RUN sudo chmod 777 /home/solutions/install_packages.sh
RUN sudo chmod a+x /home/solutions/install_packages.sh
RUN sudo sed -i -e 's/\r$//' /home/solutions/install_packages.sh