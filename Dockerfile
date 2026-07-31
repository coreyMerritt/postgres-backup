FROM postgres:18-alpine

WORKDIR /opt

COPY * ./

CMD ["sh", "./postgres-backup.sh"]
