{{- define "auth-ca" -}}
{{- $altNames := list ( printf "%s.%s.%s.%s.%s" "auth-service" .Release.Namespace "svc" "cluster" "local") ( printf "%s.%s.%s" "auth-service" .Release.Namespace "svc") ( printf "%s.%s" "auth-service" .Release.Namespace) -}}
{{- $ca := genCA "auth-service-ca" 3650 -}}
{{- $cert := genSignedCert "auth-service" nil $altNames 3650 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
ca: {{ $ca.Cert | b64enc }}
{{- end -}}