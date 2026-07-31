FROM postgres:18-alpine

WORKDIR /opt

COPY * ./

# This package fixes some datetime rendering issues
RUN apk add --no-cache coreutils

CMD ["sh", "./postgres-backup.sh"]
