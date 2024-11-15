# Implantação no EKS

## 1. Configurando Provedores OIDC e IAM para EKS

Associe o provedor OIDC ao cluster `testGeonode`:

``` bash
eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster testGeonode --approve
```
## 2. Criando a Conta de Serviço IAM para o AWS Load Balancer Controller

Para criar a conta de serviço IAM e a política necessária para o AWS Load Balancer Controller: 

Crie a política IAM a partir do arquivo de política:

``` bash
curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
```

Crie a conta de serviço IAM:

``` bash
eksctl create iamserviceaccount \
    --cluster=testGeonode \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::XXX:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --approve
```

## 3. Instalando o AWS Load Balancer Controller com Helm

Adicione o repositório Helm do EKS e atualize:

``` bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```
Instale o AWS Load Balancer Controller no cluster `testGeonode`:

``` bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    -n kube-system \
    --set clusterName=testGeonode \
    --set serviceAccount.create=false \
    --set serviceAccount.name=aws-load-balancer-controller \
    --set region=us-west-1 \
    --set vpcId=vpc-XXX \
    --set replicaCount=2
```
Verifique se o controlador está em execução:
``` bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```

## 4. Instalando e Configurando o Controlador EBS CSI

Instale o driver EBS CSI no cluster `testGeonode`:

``` bash
eksctl create addon --name aws-ebs-csi-driver --cluster testGeonode --region us-east-1
```

Migre para a identidade de pod, se necessário:

``` bash
eksctl utils migrate-to-pod-identity --cluster testGeonode --region us-east-1 --approve
```

Verifique os pods do driver EBS CSI:

``` bash
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver
```

## 5. Criando Segredos do Kubernetes para Registro Docker

Crie um segredo para o registro Docker:

``` bash
kubectl create secret docker-registry registrykey \
    --docker-server=registry.kan.com.ar \
    --docker-username=XXX \
    --docker-password=XXX \
    --docker-email=XXX
```

## 6. Implantando Recursos do Kubernetes

Para implantar esses arquivos na ordem correta, siga este fluxo:

- **Cluster e StorageClass**
    - `cluster.yaml` em `clusterEksctl` (se o cluster ainda não tiver sido criado).
    - `local-storageclass.yaml` em `configs/storageclass` (para configurar o StorageClass antes de criar volumes).
- **Banco de dados**
    - ConfigMap: `gndatabase-configmap.yaml` em `database/configmaps`.
    - PVC: `dbdata-pvc.yaml` em `database/volumes`.
    - Implantação: `gndatabase-deployment.yaml` em `database/deployments`.
    - Serviço: `gndatabase-service.yaml` em `database/services`.
- **Componentes gn-cloud**
    - ConfigMaps em `gn-cloud/configmaps` (para garantir que todas as configurações estejam disponíveis).
    - PVCs: `statics-pvc.yaml` e `tmp-pvc.yaml` em `gn-cloud/volumes`.
    - Implantações: `deploy celery`, `django`, `mapstore`, `memcache` e `redis` em `gn-cloud/deployments`.
    - Serviços para cada componente em `gn-cloud/services`.
- **Componentes gs-cloud**
    - ConfigMaps em `gs-cloud/configmaps` (para garantir que todas as configurações estejam prontas).
    - PVCs: `geowebcache-data-persistentvolumeclaim.yaml` e `rabbitmq-data-persistentvolumeclaim.yaml` em `gs-cloud/volumes`.
    - Implantações: `deploy acl`, `gateway`, `gwc`, `rabbitmq`, `rest`, `wcs`, `webui`, `wfs` e `wms` em `gs-cloud/deployments`.
    - Serviços em `gs-cloud/services`.
- **Entrada**
    - Por fim, aplique `geonode-ingress.yaml` em `configs/ingress` para expor serviços externamente.

Depois de concluir essas etapas, verifique o status dos pods e serviços.
