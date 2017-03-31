#!/bin/bash

# if flood enabled then log
if [[ "${ENABLE_FLOOD}" == "yes" ]]; then
    echo "[info] Flood enabled, disabling initialisation of ruTorrent plugins..."
else
    echo "[info] Initialising ruTorrent plugins (checking rTorrent is running)..."
    # wait for rtorrent process to start (listen for port)
    while [[ $(netstat -lnt | awk '$6 == "LISTEN" && $4 ~ ".5000"') == "" ]]; do
        sleep 0.1
    done
    echo "[info] rTorrent running"
    echo "[info] Initialising ruTorrent plugins (checking nginx is running)..."
    # wait for nginx process to start (listen for port)
    while [[ $(netstat -lnt | awk '$6 == "LISTEN" && $4 ~ ".9080"') == "" ]]; do
        sleep 0.1
    done
    echo "[info] nginx running"
    echo "[info] Initialising ruTorrent plugins..."
    # run php plugins for rutorent (required for scheduler and rss feed plugins)
    /usr/bin/php /usr/share/webapps/rutorrent/php/initplugins.php admin
    echo "[info] ruTorrent plugins initialised"
fi
