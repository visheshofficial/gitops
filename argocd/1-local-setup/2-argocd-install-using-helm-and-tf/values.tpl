configs:
  clusterCredentials: {}
  cm:
    admin.enabled: true
    accounts.alice: apiKey, login
    accounts.bob: apiKey, login
    accounts.ram: apiKey, login
    accounts.bob.enabled: false
    accounts.automation: apiKey
#    url: https://argocd.upandrunning.local
#   dex.config: |
#     connectors:
#       - type: github
#         id: github
#         name: GitHub
#         config:
#           clientID: "${GH_CLIENT_ID}"
#           clientSecret: "${GH_CLIENT_SECRET}"
#           # redirectURI: https://argocd.upandrunning.local/api/dex/callback
#           orgs:
#           - name: "${ORG_NAME}"
# rbac:
#   policy.csv: |
#     g, alice, role:admin
#     g, vishesh.bhagat@vodafone.com, role:admin
#     g, VFG-VBPS-PPE:Cloud Platforms, role:admin
#   scopes: '[groups, email]'  
#server:
#  ingress:
#    enabled: true
#    hostname: argocd.upandrunning.local
#    ingressClassName: nginx
#  extraArgs:
#    - --insecure
