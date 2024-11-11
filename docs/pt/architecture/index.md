# Arquitetura e Tecnologia

A arquitetura da solução está dividida nos seguintes componentes:

* [GeoNode Cloud Core](https://github.com/Kan-T-IT/geonode-cloud-core): Contém os elementos de infraestrutura fundamentais do GeoNode na nuvem.
* [GeoNode Cloud Mapstore Client](https://github.com/Kan-T-IT/geonode-cloud-mapstore-client): Fornece a interface de usuário para visualização e manipulação de mapas.
* [RabbitMQ](https://github.com/rabbitmq): Um broker de mensagens que facilita a comunicação assíncrona entre serviços.
* [GeoServer Cloud](https://github.com/geoserver/geoserver-cloud): Gerencia e publica dados geoespaciais.
* [Postgres](https://github.com/postgres) com extensão PostGIS: Um banco de dados relacional que permite o armazenamento e consulta de dados espaciais.
* [Nginx](https://github.com/nginx/nginx): Um servidor web e balanceador de carga.
* [Flower](https://github.com/mher/flower): Um monitor de tarefas para Celery.

O componente **GeoNode Cloud Core** inclui as seguintes tecnologias principais para sua operação:

* Django Framework
* Memcached
* GeoNode Import
* [pyCSW](https://github.com/geopython/pycsw)
* Celery
* [GeoServer App Django - ACL Capability](https://github.com/Kan-T-IT/geonode-cloud-core/tree/main/geonode/geoserver/acl)

A arquitetura é baseada em uma abordagem de microsserviços, com planos de decompor gradualmente componentes atualmente dentro da configuração monolítica do Django em microsserviços separados.

## Distribuição e Implantação

As imagens Docker para todos os serviços estão disponíveis no DockerHub sob a organização [KAN Territory & IT](https://hub.docker.com/u/kantit).

Os arquivos de implantação prontos para produção para `docker-compose` e `podman` estão disponíveis na pasta [docs/deploy](docs/deploy).

## Contribuindo

Leia as [diretrizes de contribuição](CONTRIBUTING.md) antes de enviar pull requests para o projeto GeoNode Cloud.

Siga o [guia do desenvolvedor]() para mais detalhes sobre os aspectos técnicos do projeto.

## Status

Consulte o [changelog](https://github.com/Kan-T-IT/geonode-cloud/releases) para as últimas atualizações.

## Bugs

Relate problemas para o *GeoNode Cloud* na [página de Issues do GitHub](https://github.com/Kan-T-IT/geonode-cloud/issues).

## Roadmap

A ser determinado (TBD).
