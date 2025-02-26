server:
  serviceType: NodePort
  serviceNodePort: 32746
  authModes: 
    - server
artifactRepository:
  s3:
      bucket: argo-workflow-artifact-storage
      endpoint: argo-artifacts-minio.argocd.svc.cluster.local:9000
      insecure: true
      accessKeySecret:
        name: minio-credentials
        key: accesskey
      secretKeySecret:
        name: minio-credentials
        key: secretkey  