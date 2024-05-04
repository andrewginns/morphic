FROM oven/bun:1.1.3-alpine

RUN apk add --no-cache nodejs npm git

RUN git clone --depth=1 https://github.com/miurla/morphic /app && \
  rm -rf /app/.git && \
  cd /app && \
  bun i && \
  bun next telemetry disable

# Copy .env.local.example to .env.local (actual setting of values will be done at runtime)
RUN cp /app/.env.local.example /app/.env.local

# Copy the entrypoint script into the image and make it executable
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Specify the working directory
WORKDIR /app

# Set the entrypoint script to run when the container starts
ENTRYPOINT ["/entrypoint.sh"]

# Command to run the application
CMD ["bun", "dev"]
