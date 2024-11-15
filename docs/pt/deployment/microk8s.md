# Implantação no MicroK8S

GeoNode Cloud pode ser implantado em várias plataformas Kubernetes. Abaixo estão os passos para implantá-lo no **MicroK8S**.

## Requisitos

* MicroK8S:
    * Módulo Ingress
    * Módulo DNS
    * Módulo Cert-manager

## Instalar o MicroK8S com Snap

```bash
sudo snap install microk8s --classic
```

## Habilitar Módulos Necessários do MicroK8S

```bash
microk8s enable ingress
microk8s enable cert-manager
```

## Criar Configuração do Cert-Manager para o Let's Encrypt

Substitua `SEUEMAIL@DOMINIO.com` pelo seu próprio endereço de e-mail.

```bash
microk8s kubectl apply -f - <<EOF
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
name: letsencrypt
spec:
acme:
email: SEUEMAIL@DOMINIO.com
server: https://acme-v02.api.letsencrypt.org/directory
privateKeySecretRef:
# Recurso Secret que será usado para armazenar a chave privada da conta..
name: letsencrypt-account-key
# Adicionar um único resolvedor de desafio, HTTP01 usando nginx
solvers:
- http01:
ingress:
class: public
EOF
```

## Implantação

### Clonar o Repositório

```bash
git clone https://github.com/Kan-T-IT/geonode-cloud.git && cd geonode-cloud
```

### Configurar as Variáveis de Ambiente

Edite o arquivo `.env` com as informações necessárias:

```env
KUBERNETES_SITE_URL=GEONODE_CLOUD_FINAL_URL # Ex.: cloud.mygeonode.com
KUBERNETES_NODE_NAME=NOME_DO_SEU_CLUSTER # Geralmente é o nome da máquina host
KUBERNETES_VOL_DIR=LOCAL_DESEJADO # Esse caminho deve existir
CLUSTER_ISSUER_NAME=NOME_DO_SEU_CLUSTER_ISSUER # Criado anteriormente neste guia
SERVER_PUBLIC_IP=SEU.IP.PUB.LICO # O IPv4 público do servidor
GEONODE_PASSWORD=admin # Senha para o usuário admin do geonode
GEOSERVER_PASSWORD=geoserver # Senha para o usuário admin do geoserver
```

### Executar o Script de Instalação

```bash
./install.sh
```

GeoNode Cloud agora deve estar pronto para uso.
