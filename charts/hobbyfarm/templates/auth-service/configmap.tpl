{{- $caCert := (execute "kubectl" "get" "configmap" "-n" "kube-system" "extension-apiserver-authentication" "-o" "jsonpath='{.data.client-ca-file}'" | base64 | tr -d '\n') -}}
{{- $certData := printf "%s" $caCert -}}

apiVersion: v1
kind: ConfigMap
metadata:
  name: webhook-config
data:
  webhook-config.yaml: |
    apiVersion: v1
    kind: Config
    clusters:
      - name: example-cluster
        cluster:
          server: https://webhook-authn.hobbyfarm.svc/authenticate
          certificate-authority-data: {{ $certData }}
    contexts:
      - context:
          cluster: example-cluster
          user: ""
        name: default-context
    current-context: default-context
    users: []