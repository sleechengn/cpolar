#!/usr/bin/bash
if [ ! -e "/root/.cpolar/cpolar.yml" ];then
	/opt/cpolar/cpolar authtoken $TOKEN
fi

/usr/sbin/nginx -c /etc/nginx/nginx.conf

if [ -e "/config.sh" ]; then
	/config.sh
	rm -rf config.sh
fi

export LANG="C.UTF-8"

nohup /monitor.sh &

if [ -n "$DOMAIN"  ]; then
	/opt/cpolar/cpolar http $URL --sub-domain $DOMAIN
else
	/opt/cpolar/cpolar http $URL
fi
