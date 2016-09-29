#!/bin/bash

/tmp/banner.sh

for package in $(echo ${PACKAGES} | sed 's/,/\n/g'); do
	yum install -y ${package}
done