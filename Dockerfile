FROM azul/zulu-openjdk:19

COPY ebms-admin-2.16.8.jar /app/lib/

# Generate log file
RUN mkdir -p /app/logs \
    && touch /app/logs/ebms-admin.log \
    && ln -sf /proc/1/fd/1 /app/logs/ebms-admin.log

# Create Java user and set permissions
RUN groupadd -r java \
    && useradd -l -r -M -g java java \
    && chown -R java:java /app

EXPOSE 8080
EXPOSE 8888

WORKDIR /app
USER java

CMD java $JAVA_OPTS -cp 'lib/*' nl.clockwork.ebms.admin.StartEmbedded -hsqldb -authentication
