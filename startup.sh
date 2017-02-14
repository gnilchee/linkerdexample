#!/usr/bin/env bash
cd /root/zipkin && java -jar /root/zipkin/zipkin.jar >/dev/null 2>&1 &

cd /root/www/ && python -m SimpleHTTPServer 9999 >/dev/null 2>&1 &

cd /root/linkerd && ./linkerd ./config/linkerd.yaml
