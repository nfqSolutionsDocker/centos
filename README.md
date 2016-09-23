### CentOS 7 Base

This container has the following characteristics:
- Official base of container centos:7.
- Solutions user have sudo permissions.
- This image has got an environment variable enabled  (PACKAGES) that is ready for installation the desired software.

For example, docker-compose.yml:
```
 environment:
  - PACKAGES=git,zip
```