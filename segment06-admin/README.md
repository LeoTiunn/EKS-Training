# Administrative Topics

## Cluster Autoscaler

Update the role of the EKS nodes to allow a policy that appears as follows: 

```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "autoscaling:DescribeAutoScalingGroups",
                "autoscaling:DescribeAutoScalingInstances",
                "autoscaling:DescribeLaunchConfigurations",
                "autoscaling:DescribeTags",
                "autoscaling:SetDesiredCapacity",
                "autoscaling:TerminateInstanceInAutoScalingGroup",
                "ec2:DescribeLaunchTemplateVersions"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
```

Next add the metrics server so kubernetes can tell what is happening with the nodes: 

```
cd segment06-admin/
kubectl apply -f metrics-server-0.3.6/
```

Now install the cluster autoscaler:


```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/autoscaler/master/cluster-autoscaler/cloudprovider/aws/examples/cluster-autoscaler-autodiscover.yaml
```

Allow annotation: 

```
kubectl -n kube-system annotate deployment.apps/cluster-autoscaler cluster-autoscaler.kubernetes.io/safe-to-evict="false"
```

Edit the configuration of the cluster autoscaler: 


```
kubectl -n kube-system edit deployment.apps/cluster-autoscaler
```

Update the configuration: 

```
...
- --node-group-auto-discovery=asg:tag=k8s.io/cluster-autoscaler/enabled,k8s.io/cluster-autoscaler/eksctl-2-18
- --skip-nodes-with-system-pods=false
...
```

apply the autoscaler config: 

```
kubectl -n kube-system set image deployment.apps/cluster-autoscaler cluster-autoscaler=k8s.gcr.io/cluster-autoscaler:v1.14.7
```

A quick test: 

```
kubectl get nodes
kubectl create deployment autoscaler-demo --image=nginx
kubectl scale deployment autoscaler-demo --replicas=50
```

You should see the nodes increase as more are added to take on the load!

Deleting the deployment: 

```
kubectl delete deployment autoscaler-demo
```

Will make the nodes scale down and you'll see them go away. 


## Horizontal Pod Autoscaler


First we need to installt he Metrics server.  This server let's Kubernetes know how much load is on the machines. 


```
kubectl -n kube-system get deployment/metrics-server
```


### Test HPA

```
kubectl run httpd --image=httpd --requests=cpu=100m --limits=cpu=200m --expose --port=80
```

Create the autoscaler for the pod: 


```
kubectl autoscale deployment httpd --cpu-percent=50 --min=1 --max=10
kubectl get hpa/httpd
```
Now we can test this hpa

```
kubectl run apache-bench -i --tty --rm --image=httpd -- ab -n 500000 -c 1000 http://httpd.default.svc.cluster.local/
```

You can monitor the hpa to see what is reads: 

```
kubectl get horizontalpodautoscaler.autoscaling/httpd
```


You should see the number of pods increase. 

## Kubernetes Dashboard

```
kubectl apply –f segment06-admin/dashboard.yaml
kubectl apply –f segment06-admin/eks-admin-service-account.yaml
```

Get the token from this user: 

```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```

Now open the kube proxy to login: 

```
kubectl proxy
```

You can now open dashboard at this super easy to remember URL: 

[http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/](http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/)

## Additional user access

With AWS you need to grant others access to your cluster.  To do this they must have the following: 

* A user account with AWS
* Access granted via Kubernetes authentication

The user can add the cluster to their kubernetes config with the AWS commands we ran in the beginning: 

```
aws eks update-kubeconfig --name eksctl-2-18
```

Then they should provide their caller id to the cluster administrator: 

```
aws sts get-caller-identity
```

The person who owns the cluster can then add this users identification by running: 

```
kubectl edit cm -n kube-system aws-auth
```

They then add the following to the `configMap` after the mapRoles section: 

```
mapUsers: |
- userarn: arn:aws:iam::1234567890:user/anotherUser
  username: anotherUser
  groups:
    - system:masters
```

This user now has access to the cluster.

We can limit this user to just listing pods by assigning a group to it.  

```
kubectl apply -f role-binding.yaml
```
This creates the `read-pods` user.  By modifying the `configMap` again and changing the groups to the following: 

```
mapUsers: |
    - userarn: arn:aws:iam::188966951897:user/anotherUser
      username: read-pods
      groups:
        - read-pods
```
We now can make it so this person can only read pods.  

```
kubectl get pods
```
Works!

```
kubectl get svc
Error from server (Forbidden): services is forbidden: User "read-pods" cannot list resource "services" in API group "" in the namespace "default"
```

## Cluster Upgrades

After a year, you will need to upgrade the cluster.  When we were running 1.11 they actually just turned it off and we were unable to access a month before the stated cut off date.  

Upgrading is a normal part of managing EKS.  Luckily it's not that hard.  Just another thing you have to do!

[Instructions](https://docs.aws.amazon.com/eks/latest/userguide/update-cluster.html) are best followed from AWS's official docs as they change from time to time.  


## References:

* [Cluster Autoscaling](https://docs.aws.amazon.com/eks/latest/userguide/cluster-autoscaler.html)
* [HPA on EKS](https://docs.aws.amazon.com/eks/latest/userguide/horizontal-pod-autoscaler.html)

