#!/usr/bin/env bash
start-sample-cluster.sh
trap : TERM INT
tail -f /asterixdb/opt/local/logs/*
