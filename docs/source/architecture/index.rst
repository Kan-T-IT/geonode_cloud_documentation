Architecture & Technology
=========================

The solution architecture is divided into the following components:

* `Geonode Cloud Core <https://github.com/Kan-T-IT/geonode-cloud-core>`
* `GeoNode Cloud Mapstore Client <https://github.com/Kan-T-IT/geonode-cloud-mapstore-client>`
* `Rabbitmq <https://github.com/rabbitmq>`
* `GeoServer Cloud <https://github.com/geoserver/geoserver-cloud>`
* `Postgres <https://github.com/postgres>` with PostGis extension
* `Nginx <https://github.com/nginx/nginx>`
* `Flower <https://github.com/mher/flower>`

Specifically **Geonode Cloud Core** contains the following main technological components for its operation:

* Django Framework
* Memcached
* Geonode Import
* `pyCSW <https://github.com/geopython/pycsw>`
* Celery
* `Geoserver App Django - ACL Capability <https://github.com/Kan-T-IT/geonode-cloud-core/tree/main/geonode/geoserver/acl>`

The architecture is based on the use of microservices, where it is planned to incorporate new microservices that today are in the monolithic component of Django.

Distribution and deployment
---------------------------

Docker images for all the services are available on DockerHub, under the `KAN Territory & IT organization <https://hub.docker.com/u/kantit>`.

You can find  production-suitable deployment files for docker-compose and podman under the `docs/deploy <docs/deploy>` folder.


Contributing
------------

Please read the contribution guidelines before contributing pull requests to the Geonode Cloud project.

Follow the developer's guide to know more about the project's technical details.

Status
------

Read the `changelog <https://github.com/Kan-T-IT/geonode-cloud/releases>` for more information.

Bugs
----

*GeoNode Cloud*'s issue tracking is at this `Issues GitHub <https://github.com/Kan-T-IT/geonode-cloud/issues>` repository.

Roadmap
-------

TDB
