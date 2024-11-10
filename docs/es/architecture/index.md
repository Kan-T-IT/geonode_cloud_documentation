# Arquitectura y tecnología

La arquitectura de la solución se divide en los siguientes componentes:

* [GeoNode Cloud Core](https://github.com/Kan-T-IT/geonode-cloud-core): Contiene los elementos de infraestructura fundamentales de GeoNode en la nube.
* [GeoNode Cloud Mapstore Client](https://github.com/Kan-T-IT/geonode-cloud-mapstore-client): Proporciona la interfaz de usuario para la visualización y manipulación de mapas.
* [RabbitMQ](https://github.com/rabbitmq): Un intermediario de mensajes que facilita la comunicación asíncrona entre servicios.
* [GeoServer Cloud](https://github.com/geoserver/geoserver-cloud): Administra y publica datos geoespaciales.
* [Postgres](https://github.com/postgres) con extensión PostGIS: Una base de datos relacional que permite el almacenamiento y consulta de datos espaciales.
* [Nginx](https://github.com/nginx/nginx): Un servidor web y balanceador de carga.
* [Flower](https://github.com/mher/flower): Un monitor de tareas de Celery.

El componente **GeoNode Cloud Core** incluye las siguientes tecnologías principales para su funcionamiento:

* Framework Django
* Memcached
* GeoNode Import
* [pyCSW](https://github.com/geopython/pycsw)
* Celery
* [GeoServer App Django - Capacidad ACL](https://github.com/Kan-T-IT/geonode-cloud-core/tree/main/geonode/geoserver/acl)

La arquitectura se basa en un enfoque de microservicios, con planes para descomponer gradualmente los componentes que actualmente están en la configuración monolítica de Django en microservicios separados.

## Distribución y Despliegue

Las imágenes Docker de todos los servicios están disponibles en DockerHub bajo la organización [KAN Territory & IT](https://hub.docker.com/u/kantit).

Los archivos de despliegue listos para producción para `docker-compose` y `podman` están disponibles en la carpeta [docs/deploy](docs/deploy).

## Contribuyendo

Por favor, lee las [directrices de contribución](CONTRIBUTING.md) antes de enviar solicitudes de incorporación al proyecto GeoNode Cloud.

Sigue la [guía para desarrolladores]() para obtener más detalles sobre los aspectos técnicos del proyecto.

## Estado

Consulta el [changelog](https://github.com/Kan-T-IT/geonode-cloud/releases) para las últimas actualizaciones.

## Errores

Reporta problemas para *GeoNode Cloud* en la [página de Issues de GitHub](https://github.com/Kan-T-IT/geonode-cloud/issues).

## Hoja de ruta

Por determinar (TBD).
