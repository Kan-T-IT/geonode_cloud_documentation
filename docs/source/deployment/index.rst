Deployment
==========

For the deployment of Geonode Cloud we can deploy it on different Kubernete platforms, here are the details of the deployment on MickoK8S

Deployment on MicroK8S
----------------------

Requisites
^^^^^^^^^^

* MicroK8S.

    * Ingress module.
    * DNS module.
    * Cert-manager module.

Use snap to install microk8s

.. code-block:: bash

    sudo snap install microk8s --classic

Enable necesary micro8s modules

.. code-block:: bash
    microk8s enable ingress
    microk8s enable cert-manager

Create certmanager config to enable letsencrypt using your own email

.. code-block:: bash

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


Deployment
----------

Clone this repository

.. code-block:: bash
    git clone https://github.com/Kan-T-IT/geonode-cloud.git && cd geonode-cloud

Edit all fields in .env file with the necesary information.

.. code-block:: env

    KUBERNETES_SITE_URL=GEONODE_CLOUD_FINAL_URL    # i.e.: cloud.mygeonode.com
    KUBERNETES_NODE_NAME=YOUR_CLUSTER_NAME_NAME    # usually host machine name
    KUBERNETES_VOL_DIR=YOUR_DESIRED_LOCATION       # this path shold exist
    CLUSTER_ISSUER_NAME=YOUR_CLUSTER_ISSUER_NAME   # created earlier in this guide
    SERVER_PUBLIC_IP=YOU.RPU.BLI.CIP               # the public ipv4 of the server
    GEONODE_PASSWORD=admin                         # password for geonode admin user
    GEOSERVER_PASSWORD=geoserver                   # password for geoserver admin user

Run

.. code-block:: bash

    ./install.sh`

and enjoy.
