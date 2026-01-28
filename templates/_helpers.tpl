{{/*
Expand the name of the chart.
*/}}
{{- define "handshake.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "handshake.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "handshake.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "handshake.labels" -}}
helm.sh/chart: {{ include "handshake.chart" . }}
{{ include "handshake.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "handshake.selectorLabels" -}}
app.kubernetes.io/name: {{ include "handshake.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "handshake.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "handshake.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "handshake.auth" -}}
{{- printf "%s-auth" (include "handshake.name" .) }}
{{- end }}

{{- define "handshake.product" -}}
{{- printf "%s-product" (include "handshake.name" .) }}
{{- end }}

{{- define "handshake.order" -}}
{{- printf "%s-order" (include "handshake.name" .) }}
{{- end }}

{{- define "handshake.email" -}}
{{- printf "%s-email" (include "handshake.name" .) }}
{{- end }}

{{- define "handshake.auth.labels" -}}
app: {{ template "handshake.name" . }}
role: backend
service: auth
{{- end }}

{{- define "handshake.product.labels" -}}
app: {{ template "handshake.name" . }}
role: backend
service: product
{{- end }}

{{- define "handshake.order.labels" -}}
app: {{ template "handshake.name" . }}
role: backend
service: order
{{- end }}

{{- define "handshake.email.labels" -}}
app: {{ template "handshake.name" . }}
role: backend
service: email
{{- end }}

{{- define "handshake.auth.db" -}}
{{- printf "%s-auth-db" (include "handshake.name" .) }}
{{- end }}

{{- define "handshake.auth.db.labels" -}}
app: {{ template "handshake.name" . }}
role: db
service: auth
{{- end }}

{{- define "handshake.auth.db.port" -}}
5432
{{- end }}

{{- define "handshake.auth.db.secretName" -}}
{{ .Values.authService.database.secretName | default "handshake-auth-db" }}
{{- end }}

{{- define "handshake.auth.db.storage.accessModes" -}}
{{ .Values.authService.database.storage.accessModes | default (list "ReadWriteOnce") }}
{{- end }}

{{- define "handshake.auth.db.storage.className" -}}
{{ .Values.authService.database.storage.className | default "do-block-storage" }}
{{- end }}
