#!/bin/bash

for package in $(echo ${PACKAGES} | sed 's/,/\n/g'); do
	sudo yum install -y ${package} | while read line; do echo "install_packages: $line"; done
done