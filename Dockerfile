FROM openshift/origin-haproxy-router
ADD conf/ /var/lib/haproxy/conf/
