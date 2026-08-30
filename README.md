# CV — Despliegue self-hosted

Sitio estático, sin dependencias externas. Se sirve con NGINX dentro de un
contenedor Docker.

## Estructura

```
cv-site/
├── src/
│   ├──index.html     # el CV
│   ├──style.css      # estilos
│   ├──fonts/         # IBM Plex Mono + Inter, auto-hospedadas (woff2)
├── Dockerfile
└── nginx.conf        # gzip, cache, cabeceras de seguridad y CSP
```

## 1. Build y arranque del contenedor

Crea la iamgen `cv-site:latest`.

```bash
docker build -t cv-site:latest .
```

Luego ejecuta la imagen.

```bash
docker run -p 3002:80 --name cv-site cv-site:latest
```

Verifica que esté sano:

```bash
docker compose ps
docker inspect --format='{{json .State.Health.Status}}' cv-site
```
