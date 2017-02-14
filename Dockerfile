FROM java:8

ADD https://github.com/linkerd/linkerd/releases/download/0.8.6/linkerd-0.8.6.tgz /root/linkerd-0.8.6.tgz
ADD https://search.maven.org/remote_content?g=io.zipkin.java&a=zipkin-server&v=LATEST&c=exec /root/zipkin/zipkin.jar
ADD http://themes.3rdwavemedia.com/download/874/ /root/www/prettydocs-v1.1.zip
ADD startup.sh /root/startup.sh

RUN tar -xvf /root/linkerd-0.8.6.tgz -C /root && rm -rf /root/linkerd-0.8.6.tgz && mv /root/linkerd-0.8.6 /root/linkerd \
    && mv /root/linkerd/linkerd-0.8.6-exec /root/linkerd/linkerd && mv /root/linkerd/disco /root/linkerd/routes \
    && rm -rf /root/linkerd/routes/* \
    && cd /root/www/ && unzip prettydocs-v1.1.zip && rm -rf /root/www/__MACOSX /root/www/prettydocs-v1.1.zip \
    && mv /root/www/prettydocs-v1.1/* /root/www/ && rm -rf /root/www/prettydocs-v1.1

ADD ./routes/web /root/linkerd/routes/web
ADD linkerd.yaml /root/linkerd/config/linkerd.yaml

EXPOSE 8080 9990 9411

CMD /root/startup.sh
