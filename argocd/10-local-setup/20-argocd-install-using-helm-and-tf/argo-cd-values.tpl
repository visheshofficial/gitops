configs:
  secret:
    argocdServerAdminPassword: '$2a$10$B6sELBKuVOll7jKhoq3J8OZvbogZHWW3QpgEsOBoF3TI2vTGwAswS'
  clusterCredentials: {}
  cm:
    admin.enabled: true
    accounts.alice: apiKey, login
    accounts.bob: apiKey, login
    accounts.ram: apiKey, login
    accounts.bob.enabled: false
    accounts.automation: apiKey

    rbac.policy.csv: |
      g, alice, role:admin
server:
  service:
    type: NodePort
    nodePortHttp: 30080
    nodePortHttps: 30443
  # ingress:
  #   enabled: true
  #   hostname: argocd.upandrunning.local
  #   ingressClassName: nginx
  extraArgs:
    - --insecure

notifications:
  enabled: false

dex:
  enabled: false
