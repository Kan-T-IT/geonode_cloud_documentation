# Deployment

GeoNode Cloud can be deployed on various Kubernetes platforms. Here are the steps for deploying it on **MicroK8S**.

## Deployment on MicroK8S

### Requirements

* MicroK8S:
    * Ingress module
    * DNS module
    * Cert-manager module

### Install MicroK8S with Snap

```bash
sudo snap install microk8s --classic
```

### Enable Required MicroK8S Modules

```bash
microk8s enable ingress
microk8s enable cert-manager
```

### Create Cert-Manager Configuration for Let's Encrypt

Replace `YOUREMAIL@DOMAIN.com` with your own email address.

```bash
microk8s kubectl apply -f - <<EOF
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    email: YOUREMAIL@DOMAIN.com
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: letsencrypt-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          class: public
EOF
```

## Deployment

### Clone the Repository

```bash
git clone https://github.com/Kan-T-IT/geonode-cloud.git && cd geonode-cloud
```

### Configure the Environment Variables

Edit the `.env` file with the necessary information:

```env
KUBERNETES_SITE_URL=GEONODE_CLOUD_FINAL_URL    # i.e.: cloud.mygeonode.com
KUBERNETES_NODE_NAME=YOUR_CLUSTER_NAME_NAME    # usually host machine name
KUBERNETES_VOL_DIR=YOUR_DESIRED_LOCATION       # this path shold exist
CLUSTER_ISSUER_NAME=YOUR_CLUSTER_ISSUER_NAME   # created earlier in this guide
SERVER_PUBLIC_IP=YOU.RPU.BLI.CIP               # the public ipv4 of the server
GEONODE_PASSWORD=admin                         # password for geonode admin user
GEOSERVER_PASSWORD=geoserver                   # password for geoserver admin user
```

### Run the Installation Script

```bash
./install.sh
```

GeoNode Cloud should now be ready to use.
