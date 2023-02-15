{{- define "auth-ca" -}}
{{- $altNames := list ( printf "%s.%s.%s" "auth-service" .Release.Namespace "svc") ( printf "%s.%s" "auth-service" .Release.Namespace) -}}
{{- $ca := genCA "auth-service-ca" 3650 -}}
{{- $cert := genSignedCert "auth-service" nil $altNames 3650 $ca -}}
tls.crt: {{ $cert.Cert }}
tls.key: {{ $cert.Key }}
ca: {{ $ca.Cert }}
{{- end -}}