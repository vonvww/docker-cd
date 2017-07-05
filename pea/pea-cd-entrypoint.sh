#!/bin/bash
if [ -d "$WORKDIR" ];
then
    cd $WORKDIR
    git checkout .
    echo "Pull deploy branch ..."
    git pull https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/proper-enterprise-app.git deploy
fi

if [ ! -d "$WORKDIR" ];
then
    echo "Clone deploy branch ..."
    git clone https://${GH_OAUTH_TOKEN}@github.com/propersoft-cn/proper-enterprise-app.git -b deploy --depth=1 $WORKDIR
fi

# master
if [ -d "$WORKDIR/master" ];
then
    cd $WORKDIR/master
    sed -i "s/8080/8081/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/master/dist
    python -m SimpleHTTPServer 9001 &
fi

# merge
if [ -d "$WORKDIR/merge" ];
then
    cd $WORKDIR/merge
    sed -i "s/8080/8083/" proxy/proxy-server.js
    node proxy/proxy-server.js &
    cd $WORKDIR/merge/dist
    python -m SimpleHTTPServer 9003 &
fi

tail -f /dev/null