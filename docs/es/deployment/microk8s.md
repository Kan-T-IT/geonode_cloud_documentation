# Implementación en MicroK8S

GeoNode Cloud se puede desplegar en varias plataformas de Kubernetes. Aquí están los pasos para desplegarlo en **MicroK8S**.

## Requisitos

* MicroK8S:
    * Módulo de ingreso
    * Módulo DNS
    * Módulo de gestión de certificados

## Instalar MicroK8S con Snap

```bash
sudo snap install microk8s --classic
```

## Habilitar los Módulos Requeridos de MicroK8S

```bash
microk8s enable ingress
microk8s enable cert-manager
```

## ```bash
microk8s enable ingress
microk8s enable cert-manager
```

Crear Configuración de Cert-Manager para Let's Encrypt

Reemplaza `TUEMAIL@DOMINIO.com` con tu propia dirección de correo electrónico.

## ```bash
microk8s kubectl apply -f - <<EOF
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    email: TUEMAIL@DOMINIO.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Recurso de secreto que se utilizará para almacenar la clave privada de la cuenta.
      name: letsencrypt-account-key
    # Añadir un solo solucionador de desafíos, HTTP01 usando nginx
    solvers:
    - http01:
        ingress:
          class: public
EOF
```

### Despliegue

Clonar el repositorio

### ```bash
git clone https://github.com/Kan-T-IT/geonode-cloud.git && cd geonode-cloud
```

Configurar las Variables de Entorno

Edita el archivo `.env` con la información necesaria:

### ```env
KUBERNETES_SITE_URL=GEONODE_CLOUD_FINAL_URL # ejemplo.: cloud.mygeonode.com
KUBERNETES_NODE_NAME=YOUR_CLUSTER_NAME_NAME # usualmente el nombre de la máquina anfitriona
KUBERNETES_VOL_DIR=YOUR_DESIRED_LOCATION # esta ruta debe existir
CLUSTER_ISSUER_NAME=YOUR_CLUSTER_ISSUER_NAME # creado anteriormente en esta guía
SERVER_PUBLIC_IP=YOU.RPU.BLI.CIP # la dirección IPv4 pública del servidor
GEONODE_PASSWORD=admin  # contraseña para el usuario admin de geonode
GEOSERVER_PASSWORD=geoserver # contraseña para el usuario admin de geoserver
```

Ejecutar el Script de Instalación

```bash
./install.sh
```
