#!/bin/bash

if [ "$createdump" = "yes" ]; then
	echo "Creating dump to /data/share/ilias.tar.gz"
	/data/resources/base/createiliasdump.sh --target /data/share/ilias.tar.gz
fi

if [ "$restorefromdump" = "yes" ]; then
	echo "Restoring from /data/share/ilias.tar.gz"
	/data/resources/base/restoreilias.sh --src /data/share/ilias.tar.gz
fi

apache2ctl -D $apachestartmode