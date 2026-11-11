FROM python:3.14-slim-trixie

ARG GRAFANA_BACKUP_VERSION=1.4.2

ENV GRAFANA_BACKUP_PATH=/backups \
    GRAFANA_BACKUPS_TO_KEEP=7 \
    GRAFANA_URL="http:/grafana:3000" \
    GRAFANA_TOKEN="" \
    API_AUTH_CHECK=false \
    PIP_NO_CACHE_DIR=1

RUN pip install "grafana-backup=${GRAFANA_BACKUP_VERSION}" \
    && groupadd -g 1337 gbackup \
    && useradd -u 1447 -g gbackup -M -s /usr/sbin/nologin gbackup \
    && mkdir -p /backups \
    && chown gbackup:gbackup /backups 

COPY --chmod=755 entrypoint.sh /entrypoint.sh 

USER gbackup 
VOLUME /backups 
ENTRYPOINT ["entrypoint.sh"]

