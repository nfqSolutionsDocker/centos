#!/bin/bash

for package in $(echo ${PACKAGES} | sed 's/,/\n/g'); do
	sudo yum install -y ${package}
done