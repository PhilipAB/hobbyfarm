{{- define "auth-ca" -}}
{{- $altNames := list ( printf "%s.%s.%s.%s.%s" "auth-service" .Release.Namespace "svc" "cluster" "local") ( printf "%s.%s.%s.%s.%s:%s" "auth-service" .Release.Namespace "svc" "cluster" "local" "8080") ( printf "%s.%s.%s.%s" "10" "43" "0" "10") ( printf "%s.%s.%s" "auth-service" .Release.Namespace "svc") ( printf "%s.%s" "auth-service" .Release.Namespace) -}}
{{- $ca := genCA "hobbyfarm-webhook-ca" 3650 -}}
{{- $cert := genSignedCert "auth-service" nil $altNames 3650 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
ca: {{ $ca.Cert | b64enc }}
{{- end -}}