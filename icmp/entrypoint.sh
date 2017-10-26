#!/bin/bash

# app-dev
if [ -d "$WORKDIR/app-dev" ];
then
    cd $WORKDIR/app-dev
    node proxy/proxy-server.js &
    cd $WORKDIR/app-dev/www
    python -m SimpleHTTPServer 9000 &
fi

# merge
if [ -d "$WORKDIR/merge" ];
then
    cd $WORKDIR/merge
    sed -i "s/8080/8083/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/merge/www
    python -m SimpleHTTPServer 9003 &
fi

tail -f /dev/null
