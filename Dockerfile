FROM nginx:1.31.3-alpine

RUN apk update && apk upgrade --no-cache

# Elimina el server block por defecto y usa el nuestro
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Contenido estático
COPY src/ /usr/share/nginx/html/

# nginx:alpine ya corre como root por defecto para bindear el puerto,
# pero el proceso worker corre como 'nginx' (uid 101) — compatible con Docker rootless.
EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1:80/ >/dev/null || exit 1
