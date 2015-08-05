# openshift-roundrobin-lb

```
[vagrant@openshiftdev ~]$ git clone https://github.com/pweil-/openshift-roundrobin-lb
Cloning into 'openshift-roundrobin-lb'...
remote: Counting objects: 8, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 8 (delta 0), reused 5 (delta 0), pack-reused 0
Unpacking objects: 100% (8/8), done.
Checking connectivity... done.


[vagrant@openshiftdev ~]$ docker build -t pweil/openshift-roundrobin openshift-roundrobin-lb/.
Sending build context to Docker daemon 71.68 kB
Sending build context to Docker daemon 
Step 0 : FROM openshift/origin-haproxy-router
 ---> 4fa0e7ea9eca
Step 1 : ADD conf/ /var/lib/haproxy/conf/
 ---> 30e6f069f095
Removing intermediate container dea3362f74ae
Successfully built 30e6f069f095

[vagrant@openshiftdev ~]$ echo \
>     '{"kind":"ServiceAccount","apiVersion":"v1","metadata":{"name":"router"}}' \
>     | oc create -f -
serviceaccounts/router
[vagrant@openshiftdev ~]$ oc edit scc privileged
securitycontextconstraints/privileged


[vagrant@openshiftdev ~]$ oadm router --credentials="$KUBECONFIG" --service-account=router --images=pweil/openshift-roundrobin
password for stats user admin has been set to Vd9a09W9xi
deploymentconfigs/router
services/router

[vagrant@openshiftdev ~]$ oc get pods
NAME                  READY     STATUS    RESTARTS   AGE
hello-nginx-docker1   1/1       Running   0          2m
hello-nginx-docker2   1/1       Running   0          2m
router-1-qsuce        1/1       Running   0          10m
[vagrant@openshiftdev ~]$ oc get services
NAME               LABELS                                    SELECTOR                  IP(S)            PORT(S)
hello-nginx-http   <none>                                    name=hello-nginx-docker   172.30.140.202   27017/TCP
kubernetes         component=apiserver,provider=kubernetes   <none>                    172.30.0.1       443/TCP
router             router=router                             router=router             172.30.232.151   80/TCP
[vagrant@openshiftdev ~]$ oc get routes
NAME             HOST/PORT         PATH      SERVICE            LABELS    TLS TERMINATION
route-unsecure   www.example.com             hello-nginx-http

[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Test 2!!
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Hello World
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Test 2!!
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Hello World
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Test 2!!
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Hello World
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Test 2!!
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Hello World
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Test 2!!
[vagrant@openshiftdev ~]$ curl -H Host:www.example.com localhost
Hello World





```
