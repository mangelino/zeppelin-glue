FROM apache/zeppelin:0.7.3
EXPOSE 8080
ENV ZEPPELIN_LOG_DIR='/logs'
ENV ZEPPELIN_NOTEBOOK_DIR='/notebook'
COPY interpreter.json /zeppelin/conf/interpreter.json
RUN mkdir /root/.ssh
COPY ssh_tunnel.sh .
RUN chmod +x ssh_tunnel.sh
ENTRYPOINT ["./ssh_tunnel.sh"]