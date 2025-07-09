#!/bin/sh

# Загружаем переменные из .env файла
if [ -f .env ]; then
  export $(cat .env | xargs)
fi

# Проверка, что все обязательные переменные установлены
if [ -z "$TAG" ] || [ -z "$REGISTRY_HOST" ] || [ -z "$PASSWORD" ]; then
  echo "Error: TAG, REGISTRY_HOST, and PASSWORD must be set in .env or environment"
  exit 1
fi

echo "  Building GeoServer image version: '${REGISTRY_HOST}/geoserver:${TAG}'"
docker build \
  --build-arg PASSWORD="${PASSWORD}" \
  -t "${REGISTRY_HOST}/geoserver:${TAG}" .
