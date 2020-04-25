root@ip-172-31-18-190:~# kops create cluster --cloud=aws --zones=eu-west-1b --name=sandbox.k8s.devops.com --dns-zone=devops.com --dns private
I0425 09:43:49.351886    2964 subnets.go:184] Assigned CIDR 172.20.32.0/19 to subnet eu-west-1b
I0425 09:43:50.281200    2964 create_cluster.go:1568] Using SSH public key: /root/.ssh/id_rsa.pub
Previewing changes that will be made:

I0425 09:43:51.476175    2964 dns.go:94] Private DNS: skipping DNS validation
I0425 09:43:51.557496    2964 executor.go:103] Tasks: 0 done / 87 total; 44 can run
I0425 09:43:51.942523    2964 executor.go:103] Tasks: 44 done / 87 total; 23 can run
I0425 09:43:52.608334    2964 executor.go:103] Tasks: 67 done / 87 total; 18 can run
I0425 09:43:52.696497    2964 executor.go:103] Tasks: 85 done / 87 total; 2 can run
I0425 09:43:52.764754    2964 executor.go:103] Tasks: 87 done / 87 total; 0 can run
Will create resources:
  AutoscalingGroup/master-eu-west-1b.masters.sandbox.k8s.devops.com
        Granularity             1Minute
        LaunchConfiguration     name:master-eu-west-1b.masters.sandbox.k8s.devops.com
        MaxSize                 1
        Metrics                 [GroupDesiredCapacity, GroupInServiceInstances, GroupMaxSize, GroupMinSize, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances]
        MinSize                 1
        Subnets                 [name:eu-west-1b.sandbox.k8s.devops.com]
        SuspendProcesses        []
        Tags                    {KubernetesCluster: sandbox.k8s.devops.com, Name: master-eu-west-1b.masters.sandbox.k8s.devops.com, k8s.io/role/master: 1, kops.k8s.io/instancegroup: master-eu-west-1b, k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup: master-eu-west-1b}

  AutoscalingGroup/nodes.sandbox.k8s.devops.com
        Granularity             1Minute
        LaunchConfiguration     name:nodes.sandbox.k8s.devops.com
        MaxSize                 2
        Metrics                 [GroupDesiredCapacity, GroupInServiceInstances, GroupMaxSize, GroupMinSize, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances]
        MinSize                 2
        Subnets                 [name:eu-west-1b.sandbox.k8s.devops.com]
        SuspendProcesses        []
        Tags                    {k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup: nodes, KubernetesCluster: sandbox.k8s.devops.com, Name: nodes.sandbox.k8s.devops.com, k8s.io/role/node: 1, kops.k8s.io/instancegroup: nodes}

  DHCPOptions/sandbox.k8s.devops.com
        DomainName              eu-west-1.compute.internal
        DomainNameServers       AmazonProvidedDNS
        Shared                  false
        Tags                    {Name: sandbox.k8s.devops.com, KubernetesCluster: sandbox.k8s.devops.com, kubernetes.io/cluster/sandbox.k8s.devops.com: owned}

  EBSVolume/b.etcd-events.sandbox.k8s.devops.com
        AvailabilityZone        eu-west-1b
        Encrypted               false
        SizeGB                  20
        Tags                    {k8s.io/etcd/events: b/b, k8s.io/role/master: 1, kubernetes.io/cluster/sandbox.k8s.devops.com: owned, Name: b.etcd-events.sandbox.k8s.devops.com, KubernetesCluster: sandbox.k8s.devops.com}
        VolumeType              gp2

  EBSVolume/b.etcd-main.sandbox.k8s.devops.com
        AvailabilityZone        eu-west-1b
        Encrypted               false
        SizeGB                  20
        Tags                    {KubernetesCluster: sandbox.k8s.devops.com, k8s.io/etcd/main: b/b, k8s.io/role/master: 1, kubernetes.io/cluster/sandbox.k8s.devops.com: owned, Name: b.etcd-main.sandbox.k8s.devops.com}
        VolumeType              gp2

  IAMInstanceProfile/masters.sandbox.k8s.devops.com
        Shared                  false

  IAMInstanceProfile/nodes.sandbox.k8s.devops.com
        Shared                  false

  IAMInstanceProfileRole/masters.sandbox.k8s.devops.com
        InstanceProfile         name:masters.sandbox.k8s.devops.com id:masters.sandbox.k8s.devops.com
        Role                    name:masters.sandbox.k8s.devops.com

  IAMInstanceProfileRole/nodes.sandbox.k8s.devops.com
        InstanceProfile         name:nodes.sandbox.k8s.devops.com id:nodes.sandbox.k8s.devops.com
        Role                    name:nodes.sandbox.k8s.devops.com

  IAMRole/masters.sandbox.k8s.devops.com
        ExportWithID            masters

  IAMRole/nodes.sandbox.k8s.devops.com
        ExportWithID            nodes

  IAMRolePolicy/masters.sandbox.k8s.devops.com
        Role                    name:masters.sandbox.k8s.devops.com

  IAMRolePolicy/nodes.sandbox.k8s.devops.com
        Role                    name:nodes.sandbox.k8s.devops.com

  InternetGateway/sandbox.k8s.devops.com
        VPC                     name:sandbox.k8s.devops.com
        Shared                  false
        Tags                    {Name: sandbox.k8s.devops.com, KubernetesCluster: sandbox.k8s.devops.com, kubernetes.io/cluster/sandbox.k8s.devops.com: owned}

  Keypair/apiserver-aggregator
        Signer                  name:apiserver-aggregator-ca id:cn=apiserver-aggregator-ca
        Subject                 cn=aggregator
        Type                    client
        Format                  v1alpha2

  Keypair/apiserver-aggregator-ca
        Subject                 cn=apiserver-aggregator-ca
        Type                    ca
        Format                  v1alpha2

  Keypair/apiserver-proxy-client
        Signer                  name:ca id:cn=kubernetes
        Subject                 cn=apiserver-proxy-client
        Type                    client
        Format                  v1alpha2

  Keypair/ca
        Subject                 cn=kubernetes
        Type                    ca
        Format                  v1alpha2

  Keypair/etcd-clients-ca
        Subject                 cn=etcd-clients-ca
        Type                    ca
        Format                  v1alpha2

  Keypair/etcd-manager-ca-events
        Subject                 cn=etcd-manager-ca-events
        Type                    ca
        Format                  v1alpha2

  Keypair/etcd-manager-ca-main
        Subject                 cn=etcd-manager-ca-main
        Type                    ca
        Format                  v1alpha2

  Keypair/etcd-peers-ca-events
        Subject                 cn=etcd-peers-ca-events
        Type                    ca
        Format                  v1alpha2

  Keypair/etcd-peers-ca-main
        Subject                 cn=etcd-peers-ca-main
        Type                    ca
        Format                  v1alpha2

  Keypair/kops
        Signer                  name:ca id:cn=kubernetes
        Subject                 o=system:masters,cn=kops
        Type                    client
        Format                  v1alpha2

  Keypair/kube-controller-manager
        Signer                  name:ca id:cn=kubernetes
        Subject                 cn=system:kube-controller-manager
        Type                    client
        Format                  v1alpha2

  Keypair/kube-proxy
        Signer                  name:ca id:cn=kubernetes
        Subject                 cn=system:kube-proxy
        Type                    client
        Format                  v1alpha2

  Keypair/kube-scheduler
        Signer                  name:ca id:cn=kubernetes
        Subject                 cn=system:kube-scheduler
        Type                    client
        Format                  v1alpha2

  Keypair/kubecfg
        Signer                  name:ca id:cn=kubernetes
        Subject                 o=system:masters,cn=kubecfg
        Type                    client
        Format                  v1alpha2

  Keypair/kubelet
        Signer                  name:ca id:cn=kubernetes
        Subject                 o=system:nodes,cn=kubelet
        Type                    client
        Format                  v1alpha2

  Keypair/kubelet-api
        Signer                  name:ca id:cn=kubernetes
        Subject                 cn=kubelet-api
        Type                    client
        Format                  v1alpha2

  Keypair/master
        AlternateNames          [100.64.0.1, 127.0.0.1, api.internal.sandbox.k8s.devops.com, api.sandbox.k8s.devops.com, kubernetes, kubernetes.default, kubernetes.default.svc, kubernetes.default.svc.cluster.local]
        Signer                  name:ca id:cn=kubernetes
        Subject                 cn=kubernetes-master
        Type                    server
        Format                  v1alpha2

  LaunchConfiguration/master-eu-west-1b.masters.sandbox.k8s.devops.com
        AssociatePublicIP       true
        IAMInstanceProfile      name:masters.sandbox.k8s.devops.com id:masters.sandbox.k8s.devops.com
        ImageID                 kope.io/k8s-1.16-debian-stretch-amd64-hvm-ebs-2020-01-17
        InstanceType            m3.medium
        RootVolumeDeleteOnTermination   true
        RootVolumeSize          64
        RootVolumeType          gp2
        SSHKey                  name:kubernetes.sandbox.k8s.devops.com-0a:26:0b:10:58:a9:ce:38:7a:1c:8f:9d:b9:05:88:99 id:kubernetes.sandbox.k8s.devops.com-0a:26:0b:10:58:a9:ce:38:7a:1c:8f:9d:b9:05:88:99
        SecurityGroups          [name:masters.sandbox.k8s.devops.com]
        SpotPrice

  LaunchConfiguration/nodes.sandbox.k8s.devops.com
        AssociatePublicIP       true
        IAMInstanceProfile      name:nodes.sandbox.k8s.devops.com id:nodes.sandbox.k8s.devops.com
        ImageID                 kope.io/k8s-1.16-debian-stretch-amd64-hvm-ebs-2020-01-17
        InstanceType            t2.medium
        RootVolumeDeleteOnTermination   true
        RootVolumeSize          128
        RootVolumeType          gp2
        SSHKey                  name:kubernetes.sandbox.k8s.devops.com-0a:26:0b:10:58:a9:ce:38:7a:1c:8f:9d:b9:05:88:99 id:kubernetes.sandbox.k8s.devops.com-0a:26:0b:10:58:a9:ce:38:7a:1c:8f:9d:b9:05:88:99
        SecurityGroups          [name:nodes.sandbox.k8s.devops.com]
        SpotPrice

  ManagedFile/etcd-cluster-spec-events
        Location                backups/etcd/events/control/etcd-cluster-spec

  ManagedFile/etcd-cluster-spec-main
        Location                backups/etcd/main/control/etcd-cluster-spec

  ManagedFile/manifests-etcdmanager-events
        Location                manifests/etcd/events.yaml

  ManagedFile/manifests-etcdmanager-main
        Location                manifests/etcd/main.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-bootstrap
        Location                addons/bootstrap-channel.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-core.addons.k8s.io
        Location                addons/core.addons.k8s.io/v1.4.0.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-dns-controller.addons.k8s.io-k8s-1.12
        Location                addons/dns-controller.addons.k8s.io/k8s-1.12.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-dns-controller.addons.k8s.io-k8s-1.6
        Location                addons/dns-controller.addons.k8s.io/k8s-1.6.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-dns-controller.addons.k8s.io-pre-k8s-1.6
        Location                addons/dns-controller.addons.k8s.io/pre-k8s-1.6.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-kops-controller.addons.k8s.io-k8s-1.16
        Location                addons/kops-controller.addons.k8s.io/k8s-1.16.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-kube-dns.addons.k8s.io-k8s-1.12
        Location                addons/kube-dns.addons.k8s.io/k8s-1.12.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-kube-dns.addons.k8s.io-k8s-1.6
        Location                addons/kube-dns.addons.k8s.io/k8s-1.6.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-kube-dns.addons.k8s.io-pre-k8s-1.6
        Location                addons/kube-dns.addons.k8s.io/pre-k8s-1.6.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-kubelet-api.rbac.addons.k8s.io-k8s-1.9
        Location                addons/kubelet-api.rbac.addons.k8s.io/k8s-1.9.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-limit-range.addons.k8s.io
        Location                addons/limit-range.addons.k8s.io/v1.5.0.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-rbac.addons.k8s.io-k8s-1.8
        Location                addons/rbac.addons.k8s.io/k8s-1.8.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-storage-aws.addons.k8s.io-v1.15.0
        Location                addons/storage-aws.addons.k8s.io/v1.15.0.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-storage-aws.addons.k8s.io-v1.6.0
        Location                addons/storage-aws.addons.k8s.io/v1.6.0.yaml

  ManagedFile/sandbox.k8s.devops.com-addons-storage-aws.addons.k8s.io-v1.7.0
        Location                addons/storage-aws.addons.k8s.io/v1.7.0.yaml

  Route/0.0.0.0/0
        RouteTable              name:sandbox.k8s.devops.com
        CIDR                    0.0.0.0/0
        InternetGateway         name:sandbox.k8s.devops.com

  RouteTable/sandbox.k8s.devops.com
        VPC                     name:sandbox.k8s.devops.com
        Shared                  false
        Tags                    {Name: sandbox.k8s.devops.com, KubernetesCluster: sandbox.k8s.devops.com, kubernetes.io/cluster/sandbox.k8s.devops.com: owned, kubernetes.io/kops/role: public}

  RouteTableAssociation/eu-west-1b.sandbox.k8s.devops.com
        RouteTable              name:sandbox.k8s.devops.com
        Subnet                  name:eu-west-1b.sandbox.k8s.devops.com

  SSHKey/kubernetes.sandbox.k8s.devops.com-0a:26:0b:10:58:a9:ce:38:7a:1c:8f:9d:b9:05:88:99
        KeyFingerprint          79:75:7f:53:2b:41:6a:c9:c6:60:84:30:b7:e5:07:8c

  Secret/admin

  Secret/kube

  Secret/kube-proxy

  Secret/kubelet

  Secret/system:controller_manager

  Secret/system:dns

  Secret/system:logging

  Secret/system:monitoring

  Secret/system:scheduler

  SecurityGroup/masters.sandbox.k8s.devops.com
        Description             Security group for masters
        VPC                     name:sandbox.k8s.devops.com
        RemoveExtraRules        [port=22, port=443, port=2380, port=2381, port=4001, port=4002, port=4789, port=179]
        Tags                    {Name: masters.sandbox.k8s.devops.com, KubernetesCluster: sandbox.k8s.devops.com, kubernetes.io/cluster/sandbox.k8s.devops.com: owned}

  SecurityGroup/nodes.sandbox.k8s.devops.com
        Description             Security group for nodes
        VPC                     name:sandbox.k8s.devops.com
        RemoveExtraRules        [port=22]
        Tags                    {KubernetesCluster: sandbox.k8s.devops.com, kubernetes.io/cluster/sandbox.k8s.devops.com: owned, Name: nodes.sandbox.k8s.devops.com}

  SecurityGroupRule/all-master-to-master
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        SourceGroup             name:masters.sandbox.k8s.devops.com

  SecurityGroupRule/all-master-to-node
        SecurityGroup           name:nodes.sandbox.k8s.devops.com
        SourceGroup             name:masters.sandbox.k8s.devops.com

  SecurityGroupRule/all-node-to-node
        SecurityGroup           name:nodes.sandbox.k8s.devops.com
        SourceGroup             name:nodes.sandbox.k8s.devops.com

  SecurityGroupRule/https-external-to-master-0.0.0.0/0
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        CIDR                    0.0.0.0/0
        Protocol                tcp
        FromPort                443
        ToPort                  443

  SecurityGroupRule/master-egress
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        CIDR                    0.0.0.0/0
        Egress                  true

  SecurityGroupRule/node-egress
        SecurityGroup           name:nodes.sandbox.k8s.devops.com
        CIDR                    0.0.0.0/0
        Egress                  true

  SecurityGroupRule/node-to-master-tcp-1-2379
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        Protocol                tcp
        FromPort                1
        ToPort                  2379
        SourceGroup             name:nodes.sandbox.k8s.devops.com

  SecurityGroupRule/node-to-master-tcp-2382-4000
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        Protocol                tcp
        FromPort                2382
        ToPort                  4000
        SourceGroup             name:nodes.sandbox.k8s.devops.com

  SecurityGroupRule/node-to-master-tcp-4003-65535
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        Protocol                tcp
        FromPort                4003
        ToPort                  65535
        SourceGroup             name:nodes.sandbox.k8s.devops.com

  SecurityGroupRule/node-to-master-udp-1-65535
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        Protocol                udp
        FromPort                1
        ToPort                  65535
        SourceGroup             name:nodes.sandbox.k8s.devops.com

  SecurityGroupRule/ssh-external-to-master-0.0.0.0/0
        SecurityGroup           name:masters.sandbox.k8s.devops.com
        CIDR                    0.0.0.0/0
        Protocol                tcp
        FromPort                22
        ToPort                  22

  SecurityGroupRule/ssh-external-to-node-0.0.0.0/0
        SecurityGroup           name:nodes.sandbox.k8s.devops.com
        CIDR                    0.0.0.0/0
        Protocol                tcp
        FromPort                22
        ToPort                  22

  Subnet/eu-west-1b.sandbox.k8s.devops.com
        ShortName               eu-west-1b
        VPC                     name:sandbox.k8s.devops.com
        AvailabilityZone        eu-west-1b
        CIDR                    172.20.32.0/19
        Shared                  false
        Tags                    {Name: eu-west-1b.sandbox.k8s.devops.com, KubernetesCluster: sandbox.k8s.devops.com, kubernetes.io/cluster/sandbox.k8s.devops.com: owned, SubnetType: Public, kubernetes.io/role/elb: 1}

  VPC/sandbox.k8s.devops.com
        CIDR                    172.20.0.0/16
        EnableDNSHostnames      true
        EnableDNSSupport        true
        Shared                  false
        Tags                    {Name: sandbox.k8s.devops.com, KubernetesCluster: sandbox.k8s.devops.com, kubernetes.io/cluster/sandbox.k8s.devops.com: owned}

  VPCDHCPOptionsAssociation/sandbox.k8s.devops.com
        VPC                     name:sandbox.k8s.devops.com
        DHCPOptions             name:sandbox.k8s.devops.com

Will modify resources:
  DNSZone/devops.com
        PrivateVPC               <nil> -> name:sandbox.k8s.devops.com

Must specify --yes to apply changes

Cluster configuration has been created.

Suggestions:
 * list clusters with: kops get cluster
 * edit this cluster with: kops edit cluster sandbox.k8s.devops.com
 * edit your node instance group: kops edit ig --name=sandbox.k8s.devops.com nodes
 * edit your master instance group: kops edit ig --name=sandbox.k8s.devops.com master-eu-west-1b

Finally configure your cluster with: kops update cluster --name sandbox.k8s.devops.com --yes

root@ip-172-31-18-190:~#