#!/bin/bash

# admin
if [ -d "$WORKDIR/admin" ];
then
    cd $WORKDIR/admin
    sed -i "s/8080/8082/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/admin/www
    python -m SimpleHTTPServer 9002 &
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

# app-3.x
if [ -d "$WORKDIR/app-3.x" ];
then
    cd $WORKDIR/app-3.x
    sed -i "s/8080/8084/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/app-3.x/www
    python -m SimpleHTTPServer 9004 &
fi

# app-grey
if [ -d "$WORKDIR/app-grey" ];
then
    cd $WORKDIR/app-grey
    sed -i "s/8080/8085/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/app-grey/www
    rm -f index.html
    python -m SimpleHTTPServer 9005 &
fi

tail -f /dev/null
