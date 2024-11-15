# Implementación en EKS

## 1. Configuración de Proveedores OIDC e IAM para EKS

Asociar el proveedor OIDC al clúster `testGeonode`:

``` bash
eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster testGeonode --approve
```
## 2. Creación de la Cuenta de Servicio IAM para AWS Load Balancer Controller

Para crear la cuenta de servicio IAM y la política requerida para el AWS Load Balancer Controller:

Crear la política IAM desde el archivo de política:

``` bash
curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
```

Crear la cuenta de servicio IAM:

``` bash
eksctl create iamserviceaccount \
    --cluster=testGeonode \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::XXX:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --approve
```

## 3. Instalación del AWS Load Balancer Controller mediante Helm

Agregar el repositorio de Helm de EKS y actualizar:

``` bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```
Instalar el AWS Load Balancer Controller en el clúster `testGeonode`:

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
Verificar que el controlador está funcionando:
``` bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```

## 4. Instalación y Configuración del Controlador EBS CSI

Instalar el addon EBS CSI Driver en el clúster `testGeonode`:

``` bash
eksctl create addon --name aws-ebs-csi-driver --cluster testGeonode --region us-east-1
```

Migrar a identidad de pod (si es necesario):

``` bash
eksctl utils migrate-to-pod-identity --cluster testGeonode --region us-east-1 --approve
```

Verificar los pods del EBS CSI Driver:

``` bash
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver
```

## 5. Creación de Secretos de Kubernetes para Registro de Docker

Crear un secreto de registro Docker:

``` bash
kubectl create secret docker-registry registrykey \
    --docker-server=registry.kan.com.ar \
    --docker-username=XXX \
    --docker-password=XXX \
    --docker-email=XXX
```

## 6. Despliegue de Recursos Kubernetes

Para desplegar estos archivos en orden, sigue este flujo:

- **Cluster y StorageClass**
    - `cluster.yaml` en `clusterEksctl` (si el clúster aún no está creado).
    - `local-storageclass.yaml` en `configs/storageclass` (para configurar StorageClass antes de crear volúmenes).
- **Base de datos**
    - ConfigMap: `gndatabase-configmap.yaml` en `database/configmaps`.
    - PVC: `dbdata-pvc.yaml` en `database/volumes`.
    - Deployment: `gndatabase-deployment.yaml` en `database/deployments`.
    - Service: `gndatabase-service.yaml` en `database/services`.
- **gn-cloud Componentes**
    - ConfigMaps en `gn-cloud/configmaps` (para que todas las configuraciones estén disponibles).
    - PVC: `statics-pvc.yaml` y `tmp-pvc.yaml` en `gn-cloud/volumes`.
    - Deployments: despliega `celery`, `django`, `mapstore`, `memcache` y `redis` en `gn-cloud/deployments`.
    - Services para cada componente en `gn-cloud/services`.
- **gs-cloud Componentes**
    - ConfigMaps en `gs-cloud/configmaps` (para garantizar que todas las configuraciones estén listas).
    - PVC: `geowebcache-data-persistentvolumeclaim.yaml` y `rabbitmq-data-persistentvolumeclaim.yaml` en `gs-cloud/volumes`.
    - Deployments: despliega `acl`, `gateway`, `gwc`, `rabbitmq`, `rest`, `wcs`, `webui`, `wfs` y `wms` en `gs-cloud/deployments`.
    - Services en `gs-cloud/services`.
- **Ingress**
    - Finalmente, aplica `geonode-ingress.yaml` en `configs/ingress` para exponer los servicios al exterior.

Después de realizar estos pasos, verificar el estado de los pods y servicios.
