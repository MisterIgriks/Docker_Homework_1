ARG PORT=5000
ARG TAG=20

FROM node:${TAG}

ENV PORT $PORT

RUN groupadd -r app && useradd -r -g app -m -d /home/app app

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN chown -R app:app /app && \
    chmod -R 755 /app

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

EXPOSE $PORT

USER app

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -fs http://192.168.0.99:$PORT/healthz || exit 1


LABEL maintainer="Your Name misterigriks@gmail.com"
LABEL version="1.0"
LABEL description="Node.js application"

