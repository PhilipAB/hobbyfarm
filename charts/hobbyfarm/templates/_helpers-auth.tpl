{{- define "auth-ca" -}}
{{- $altNames := list ( printf "%s.%s.%s" "webhook-authn" .Release.Namespace "svc") ( printf "%s.%s" "webhook-authn" .Release.Namespace) -}}
{{- $ca := genCA "webhook-authn-ca" 3650 -}}
{{- $cert := genSignedCert "webhook-authn" nil $altNames 3650 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
ca: {{ $ca.Cert | b64enc }}
{{- end -}}