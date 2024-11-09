# Architecture & Technology

The solution architecture is divided into the following components:

* [GeoNode Cloud Core](https://github.com/Kan-T-IT/geonode-cloud-core): Contains the foundational infrastructure elements of GeoNode in the cloud.
* [GeoNode Cloud Mapstore Client](https://github.com/Kan-T-IT/geonode-cloud-mapstore-client): Provides the user interface for map visualization and manipulation.
* [RabbitMQ](https://github.com/rabbitmq): A message broker that facilitates asynchronous communication between services.
* [GeoServer Cloud](https://github.com/geoserver/geoserver-cloud): Manages and publishes geospatial data.
* [Postgres](https://github.com/postgres) with PostGIS extension:  A relational database that allows spatial data storage and querying.
* [Nginx](https://github.com/nginx/nginx):  A web server and load balancer.
* [Flower](https://github.com/mher/flower):  A Celery task monitor.

The **GeoNode Cloud Core** component includes the following main technologies for its operation:

* Django Framework
* Memcached
* GeoNode Import
* [pyCSW](https://github.com/geopython/pycsw)
* Celery
* [GeoServer App Django - ACL Capability](https://github.com/Kan-T-IT/geonode-cloud-core/tree/main/geonode/geoserver/acl)

The architecture is based on a microservices approach, with plans to gradually decompose components currently within the monolithic Django setup into separate microservices.

## Distribution and Deployment

Docker images for all services are available on DockerHub under the [KAN Territory & IT organization](https://hub.docker.com/u/kantit).

Production-ready deployment files for `docker-compose` and `podman` are available in the [docs/deploy](docs/deploy) folder.

## Contributing

Please read the [contribution guidelines](CONTRIBUTING.md) before submitting pull requests to the GeoNode Cloud project.

Follow the [developer's guide]() for more details on the project's technical aspects.

## Status

Check the [changelog](https://github.com/Kan-T-IT/geonode-cloud/releases) for the latest updates.

## Bugs

Report issues for *GeoNode Cloud* on the [Issues GitHub page](https://github.com/Kan-T-IT/geonode-cloud/issues).

## Roadmap

To be determined (TBD).
