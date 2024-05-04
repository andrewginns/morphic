#!/bin/sh

# Dynamically set environment variables in .env.local from Docker environment variables
sed -i "s/# OPENAI_API_MODEL=.*/OPENAI_API_MODEL='${OPENAI_API_MODEL}'/" /app/.env.local
sed -i "s/OPENAI_API_KEY=.*/OPENAI_API_KEY=${OPENAI_API_KEY}/" /app/.env.local
sed -i "s/TAVILY_API_KEY=.*/TAVILY_API_KEY=${TAVILY_API_KEY}/" /app/.env.local
sed -i "s|UPSTASH_REDIS_REST_URL=.*|UPSTASH_REDIS_REST_URL=${UPSTASH_REDIS_REST_URL}|" /app/.env.local
sed -i "s/UPSTASH_REDIS_REST_TOKEN=.*/UPSTASH_REDIS_REST_TOKEN=${UPSTASH_REDIS_REST_TOKEN}/" /app/.env.local

# Modify the 'dev' script in package.json to listen on a specific address
sed -i "s/\"dev\": \"next dev\"/\"dev\": \"next dev -H ${HOST_ADDR}\"/" /app/package.json

# Execute the main container command
exec "$@"
