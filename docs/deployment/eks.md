# Deployment on EKS

## 1. Configuring OIDC Providers and IAM for EKS

Associate the OIDC provider with the `testGeonode` cluster:

``` bash
eksctl utils associate-iam-oidc-provider --region us-east-1 --cluster testGeonode --approve
```
## 2. Creating the IAM Service Account for AWS Load Balancer Controller

To create the IAM service account and the required policy for the AWS Load Balancer Controller:

Create the IAM policy from the policy file:

``` bash
curl -o iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
```

Create the IAM service account:

``` bash
eksctl create iamserviceaccount \
    --cluster=testGeonode \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::XXX:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --approve
```

## 3. Installing AWS Load Balancer Controller with Helm

Add the EKS Helm repository and update:

``` bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```
Install the AWS Load Balancer Controller on the `testGeonode` cluster:

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
Verify the controller is running:
``` bash
kubectl get deployment -n kube-system aws-load-balancer-controller
```

## 4. Installing and Configuring the EBS CSI Controller

Install the EBS CSI Driver addon on the `testGeonode` cluster:

``` bash
eksctl create addon --name aws-ebs-csi-driver --cluster testGeonode --region us-east-1
```

Migrate to pod identity if necessary:

``` bash
eksctl utils migrate-to-pod-identity --cluster testGeonode --region us-east-1 --approve
```

Verify the EBS CSI Driver pods:

``` bash
kubectl get pods -n kube-system -l app.kubernetes.io/name=aws-ebs-csi-driver
```

## 5. Creating Kubernetes Secrets for Docker Registry

Create a Docker registry secret:

``` bash
kubectl create secret docker-registry registrykey \
    --docker-server=registry.kan.com.ar \
    --docker-username=XXX \
    --docker-password=XXX \
    --docker-email=XXX
```

## 6. Deploying Kubernetes Resources

To deploy these files in order, follow this workflow:

- **Cluster and StorageClass**
    - `cluster.yaml` in `clusterEksctl` (if the cluster is not yet created).
    - `local-storageclass.yaml` in `configs/storageclass` (to set up the StorageClass before creating volumes).
- **Database**
    - ConfigMap: `gndatabase-configmap.yaml` in `database/configmaps`.
    - PVC: `dbdata-pvc.yaml` in `database/volumes`.
    - Deployment: `gndatabase-deployment.yaml` in `database/deployments`.
    - Service: `gndatabase-service.yaml` in `database/services`.
- **gn-cloud Components**
    - ConfigMaps in `gn-cloud/configmaps` (to ensure all configurations are available).
    - PVCs: `statics-pvc.yaml` and `tmp-pvc.yaml` in `gn-cloud/volumes`.
    - Deployments: `deploy celery`, `django`, `mapstore`, `memcache`, and `redis` in `gn-cloud/deployments`.
    - Services for each component in `gn-cloud/services`.
- **gs-cloud Components**
    - ConfigMaps in `gs-cloud/configmaps` (to ensure all configurations are ready).
    - PVCs: `geowebcache-data-persistentvolumeclaim.yaml` and `rabbitmq-data-persistentvolumeclaim.yaml` in `gs-cloud/volumes`.
    - Deployments: `deploy acl`, `gateway`, `gwc`, `rabbitmq`, `rest`, `wcs`, `webui`, `wfs`, and `wms` in `gs-cloud/deployments`.
    - Services in `gs-cloud/services`.
- **Ingress**
    - Finally, apply `geonode-ingress.yaml` in `configs/ingress` to expose services externally.

After completing these steps, verify the status of the pods and services.
