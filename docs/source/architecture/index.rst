Architecture & Technology
=========================

The solution architecture is divided into the following components:

* `Geonode Cloud Core <https://github.com/Kan-T-IT/geonode-cloud-core>`_
* `GeoNode Cloud Mapstore Client <https://github.com/Kan-T-IT/geonode-cloud-mapstore-client>`_
* `Rabbitmq <https://github.com/rabbitmq>`_
* `GeoServer Cloud <https://github.com/geoserver/geoserver-cloud>`_
* `Postgres <https://github.com/postgres>`_ with PostGis extension
* `Nginx <https://github.com/nginx/nginx>`_
* `Flower <https://github.com/mher/flower>`_

Specifically **Geonode Cloud Core** contains the following main technological components for its operation:

* Django Framework
* Memcached
* Geonode Import
* `pyCSW <https://github.com/geopython/pycsw>`_
* Celery
* `Geoserver App Django - ACL Capability <https://github.com/Kan-T-IT/geonode-cloud-core/tree/main/geonode/geoserver/acl>`_

The architecture is based on the use of microservices, where it is planned to incorporate new microservices that today are in the monolithic component of Django.

Distribution and deployment
---------------------------

Docker images for all the services are available on DockerHub, under the `KAN Territory & IT organization <https://hub.docker.com/u/kantit>`_.

You can find  production-suitable deployment files for docker-compose and podman under the `docs/deploy <docs/deploy>`_ folder.


Contributing
------------

Please read the contribution guidelines before contributing pull requests to the Geonode Cloud project.

Follow the developer's guide to know more about the project's technical details.

Status
------

Read the `changelog <https://github.com/Kan-T-IT/geonode-cloud/releases>`_ for more information.

Bugs
----

*GeoNode Cloud*'s issue tracking is at this `Issues GitHub <https://github.com/Kan-T-IT/geonode-cloud/issues>`_ repository.

Roadmap
-------

TDB
