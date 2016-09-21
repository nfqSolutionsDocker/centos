### CentOS 7 Base

This container has the following characteristics:
- Official base of container centos:7.
- Solutions user have sudo permissions.
- Installations script of packages in centos. This script is executing in the next containers or in the docker compose.

For example, docker-compose.yml:
...
 environment:
  - PACKAGES=git,zip
 command: /bin/bash -c "/home/solutions/install_packages.sh"
...