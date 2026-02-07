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

{{- define "handshake.frontend" -}}
{{- printf "%s-frontend" (include "handshake.name" .) }}
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

{{- define "handshake.frontend.labels" -}}
app: {{ template "handshake.name" . }}
role: frontend
{{- end }}

{{- define "handshake.auth.port" -}}
8001
{{- end }}

{{- define "handshake.product.port" -}}
8002
{{- end }}

{{- define "handshake.order.port" -}}
8003
{{- end }}

{{- define "handshake.email.port" -}}
8004
{{- end }}

{{- define "handshake.frontend.port" -}}
3000
{{- end }}

{{- define "handshake.auth.host" -}}
{{ .Values.authService.host | default "auth.sofine.my.id" }}
{{- end}}

{{- define "handshake.product.host" -}}
{{ .Values.productService.host | default "product.sofine.my.id" }}
{{- end}}

{{- define "handshake.order.host" -}}
{{ .Values.orderService.host | default "order.sofine.my.id" }}
{{- end}}

{{- define "handshake.email.host" -}}
{{ .Values.emailService.host | default "email.sofine.my.id" }}
{{- end}}

{{- define "handshake.frontend.host" -}}
{{ .Values.frontend.host | default "handshake.sofine.my.id" }}
{{- end}}

{{- define "handshake.letsencrypt.annotations" -}}
cert-manager.io/cluster-issuer: "letsencrypt-nginx-cert"
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

{{- define "handshake.product.db" -}}
{{- printf "%s-product-db" (include "handshake.name" .) }}
{{- end }}

{{- define "handshake.product.db.labels" -}}
app: {{ template "handshake.name" . }}
role: db
service: product
{{- end }}

{{- define "handshake.product.db.port" -}}
5432
{{- end }}

{{- define "handshake.product.db.secretName" -}}
{{ .Values.productService.database.secretName | default "handshake-product-db" }}
{{- end }}

{{- define "handshake.product.db.storage.accessModes" -}}
{{ .Values.productService.database.storage.accessModes | default (list "ReadWriteOnce") }}
{{- end }}

{{- define "handshake.product.db.storage.className" -}}
{{ .Values.productService.database.storage.className | default "do-block-storage" }}
{{- end }}

{{- define "handshake.order.db" -}}
{{- printf "%s-order-db" (include "handshake.name" .) }}
{{- end }}

{{- define "handshake.order.db.labels" -}}
app: {{ template "handshake.name" . }}
role: db
service: order
{{- end }}

{{- define "handshake.order.db.port" -}}
5432
{{- end }}

{{- define "handshake.order.db.secretName" -}}
{{ .Values.orderService.database.secretName | default "handshake-order-db" }}
{{- end }}

{{- define "handshake.order.db.storage.accessModes" -}}
{{ .Values.orderService.database.storage.accessModes | default (list "ReadWriteOnce") }}
{{- end }}

{{- define "handshake.order.db.storage.className" -}}
{{ .Values.orderService.database.storage.className | default "do-block-storage" }}
{{- end }}

{{- define "handshake.frontend.configName" -}}
{{ .Values.frontend.configName | default "handshake-frontend" }}
{{- end }}

{{- define "handshake.vault.role" -}}
vault.hashicorp.com/role: {{ .Release.Namespace | quote }}
{{- end }}

{{- define "handshake.vault.agentInject" -}}
vault.hashicorp.com/agent-inject: "true"
{{- end }}

{{- define "handshake.vault.pathPrefix" -}}
{{- if contains "development" .Release.Namespace -}}
secret/data/handshake/development
{{- else -}}
secret/data/handshake/production
{{- end -}}
{{- end -}}

{{- define "handshake.auth.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-auth: |
  {{ printf "%s/auth-service" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.product.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-product: |
  {{ printf "%s/product-service" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.order.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-order: |
  {{ printf "%s/order-service" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.email.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-email: |
  {{ printf "%s/email-service" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.frontend.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-frontend: |
  {{ printf "%s/frontend" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.auth.db.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-auth-db: |
  {{ printf "%s/databases/auth-service-db" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.product.db.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-product-db: |
  {{ printf "%s/databases/product-service-db" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.order.db.vault.agentInject.secret" -}}
vault.hashicorp.com/agent-inject-secret-order-db: |
  {{ printf "%s/databases/order-service-db" (include "handshake.vault.pathPrefix" .) }}
{{- end }}

{{- define "handshake.auth.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-auth: |
  {{ printf "{{- with secret \"%s/auth-service\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.product.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-product: |
  {{ printf "{{- with secret \"%s/product-service\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.order.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-order: |
  {{ printf "{{- with secret \"%s/order-service\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.email.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-email: |
  {{ printf "{{- with secret \"%s/email-service\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.frontend.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-frontend: |
  {{ printf "{{- with secret \"%s/frontend\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.auth.db.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-auth-db: |
  {{ printf "{{- with secret \"%s/databases/auth-service-db\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.product.db.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-product-db: |
  {{ printf "{{- with secret \"%s/databases/product-service-db\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.order.db.vault.agentInject.template" -}}
vault.hashicorp.com/agent-inject-template-order-db: |
  {{ printf "{{- with secret \"%s/databases/order-service-db\" -}}" (include "handshake.vault.pathPrefix" .) }}
    {{`{{ range $key, $value := .Data.data }}`}}
      export {{`{{ $key }}="{{ $value }}"`}}
    {{`{{ end }}`}}
  {{`{{- end }}`}}
{{- end }}

{{- define "handshake.auth.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-auth: "source /vault/secrets/auth"
{{- end }}

{{- define "handshake.product.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-product: "source /vault/secrets/product"
{{- end }}

{{- define "handshake.order.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-order: "source /vault/secrets/order"
{{- end }}

{{- define "handshake.email.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-email: "source /vault/secrets/email"
{{- end }}

{{- define "handshake.frontend.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-frontend: "source /vault/secrets/frontend"
{{- end }}

{{- define "handshake.auth.db.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-auth-db: "source /vault/secrets/auth-db"
{{- end }}

{{- define "handshake.product.db.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-product-db: "source /vault/secrets/product-db"
{{- end }}

{{- define "handshake.order.db.vault.agentInject.command" -}}
vault.hashicorp.com/agent-inject-command-order-db: "source /vault/secrets/order-db"
{{- end }}

{{- define "handshake.vault.cpu" -}}
vault.hashicorp.com/agent-limits-cpu: ""
vault.hashicorp.com/agent-requests-cpu: ""
{{- end }}

{{- define "handshake.vault.mem" -}}
vault.hashicorp.com/agent-limits-mem: "64Mi"
vault.hashicorp.com/agent-requests-mem: "32Mi"
{{- end }}

{{- define "handshake.auth.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.auth.vault.agentInject.secret" . }}
{{ template "handshake.auth.vault.agentInject.template" . }}
{{ template "handshake.auth.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.product.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.product.vault.agentInject.secret" . }}
{{ template "handshake.product.vault.agentInject.template" . }}
{{ template "handshake.product.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.order.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.order.vault.agentInject.secret" . }}
{{ template "handshake.order.vault.agentInject.template" . }}
{{ template "handshake.order.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.email.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.email.vault.agentInject.secret" . }}
{{ template "handshake.email.vault.agentInject.template" . }}
{{ template "handshake.email.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.frontend.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.frontend.vault.agentInject.secret" . }}
{{ template "handshake.frontend.vault.agentInject.template" . }}
{{ template "handshake.frontend.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.auth.db.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.auth.db.vault.agentInject.secret" . }}
{{ template "handshake.auth.db.vault.agentInject.template" . }}
{{ template "handshake.auth.db.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.product.db.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.product.db.vault.agentInject.secret" . }}
{{ template "handshake.product.db.vault.agentInject.template" . }}
{{ template "handshake.product.db.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.order.db.vault.annotations" -}}
{{ template "handshake.vault.role" . }}
{{ template "handshake.vault.agentInject" . }}
{{ template "handshake.order.db.vault.agentInject.secret" . }}
{{ template "handshake.order.db.vault.agentInject.template" . }}
{{ template "handshake.order.db.vault.agentInject.command" . }}
{{ template "handshake.vault.mem" . }}
{{ template "handshake.vault.cpu" . }}
{{- end }}

{{- define "handshake.auth.resources" -}}
requests:
  cpu: {{ .Values.authService.requests.cpu | default "100m" }}
  memory: {{ .Values.authService.requests.memory | default "64Mi" }}
limits:
  memory: {{ .Values.authService.limits.memory | default "64Mi" }}
{{- end }}

{{- define "handshake.product.resources" -}}
requests:
  cpu: {{ .Values.productService.requests.cpu | default "100m" }}
  memory: {{ .Values.productService.requests.memory | default "64Mi" }}
limits:
  memory: {{ .Values.productService.limits.memory | default "64Mi" }}
{{- end }}

{{- define "handshake.order.resources" -}}
requests:
  cpu: {{ .Values.orderService.requests.cpu | default "100m" }}
  memory: {{ .Values.orderService.requests.memory | default "64Mi" }}
limits:
  memory: {{ .Values.orderService.limits.memory | default "64Mi" }}
{{- end }}

{{- define "handshake.email.resources" -}}
requests:
  cpu: {{ .Values.emailService.requests.cpu | default "100m" }}
  memory: {{ .Values.emailService.requests.memory | default "64Mi" }}
limits:
  memory: {{ .Values.emailService.limits.memory | default "64Mi" }}
{{- end }}

{{- define "handshake.frontend.resources" -}}
requests:
  cpu: {{ .Values.frontend.requests.cpu | default "100m" }}
  memory: {{ .Values.frontend.requests.memory | default "128Mi" }}
limits:
  memory: {{ .Values.frontend.limits.memory | default "128Mi" }}
{{- end }}
