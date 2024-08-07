{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prometheus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create labels for prometheus

K10 NOTE:

  The selector labels here (`app` and `release`) are divergent from the
  selector labels set by the upstream chart. This is intentional since a
  Deployment's `spec.selector` is immutable and K10 has already been shipped
  with these values.

  A change to these selector labels will mean that all customers must manually
  delete the Prometheus Deployment before upgrading, which is a situation we don't
  want for our customers.

  Instead, the `app.kubernetes.io/name` and `app.kubernetes.io/instance` labels
  are included in the `prometheus.common.metaLabels` block below.

*/}}
{{- define "prometheus.common.matchLabels" -}}
{{/*app.kubernetes.io/name: {{ include "prometheus.name" . }}*/}}
{{/*app.kubernetes.io/instance: {{ .Release.Name }}*/}}
app: {{ template "prometheus.name" . }}
release: {{ .Release.Name }}
{{- end -}}

{{/*
Create unified labels for prometheus components
*/}}
{{- define "prometheus.common.metaLabels" -}}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ include "prometheus.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "prometheus.name" . }}
app.kubernetes.io/name: {{ include "prometheus.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- with .Values.commonMetaLabels}}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "prometheus.alertmanager.labels" -}}
{{ include "prometheus.alertmanager.matchLabels" . }}
{{ include "prometheus.common.metaLabels" . }}
{{- end -}}

{{- define "prometheus.alertmanager.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.alertmanager.name }}
{{ include "prometheus.common.matchLabels" . }}
{{- end -}}

{{- define "prometheus.nodeExporter.labels" -}}
{{ include "prometheus.nodeExporter.matchLabels" . }}
{{ include "prometheus.common.metaLabels" . }}
{{- end -}}

{{- define "prometheus.nodeExporter.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.nodeExporter.name }}
{{ include "prometheus.common.matchLabels" . }}
{{- end -}}

{{- define "prometheus.pushgateway.labels" -}}
{{ include "prometheus.pushgateway.matchLabels" . }}
{{ include "prometheus.common.metaLabels" . }}
{{- end -}}

{{- define "prometheus.pushgateway.matchLabels" -}}
app.kubernetes.io/component: {{ .Values.pushgateway.name }}
{{ include "prometheus.common.matchLabels" . }}
{{- end -}}

{{- define "prometheus.server.labels" -}}
{{ include "prometheus.server.matchLabels" . }}
{{ include "prometheus.common.metaLabels" . }}
app.kubernetes.io/component: {{ .Values.server.name }}
{{- end -}}

{{/*
Selector labels

K10 NOTE:

  The selector label here (`component`) is divergent from the
  selector label set by the upstream chart. This is intentional since a
  Deployment's `spec.selector` is immutable and K10 has already been
  shipped with this value.

  A change to this selector label will mean that all customers must manually
  delete the Prometheus Deployment before upgrading, which is a situation we don't
  want for our customers.

  Instead, the `app.kubernetes.io/component` labels is included in the
  `prometheus.server.labels` block above.

*/}}
{{- define "prometheus.server.matchLabels" -}}
{{/*app.kubernetes.io/component: {{ .Values.server.name }}*/}}
component: {{ .Values.server.name | quote }}
{{ include "prometheus.common.matchLabels" . }}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified ClusterRole name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.clusterRoleName" -}}
{{- if .Values.server.clusterRoleNameOverride -}}
{{ .Values.server.clusterRoleNameOverride | trunc 63 | trimSuffix "-" }}
{{- else -}}
{{ include "prometheus.server.fullname" . }}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified alertmanager name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}

{{- define "prometheus.alertmanager.fullname" -}}
{{- template "alertmanager.fullname" .Subcharts.alertmanager -}}
{{- end -}}

{{/*
Create a fully qualified node-exporter name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.nodeExporter.fullname" -}}
{{- if .Values.nodeExporter.fullnameOverride -}}
{{- .Values.nodeExporter.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.nodeExporter.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.nodeExporter.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified Prometheus server name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.server.fullname" -}}
{{- if .Values.server.fullnameOverride -}}
{{- .Values.server.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.server.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.server.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create a fully qualified pushgateway name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.pushgateway.fullname" -}}
{{- if .Values.pushgateway.fullnameOverride -}}
{{- .Values.pushgateway.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- printf "%s-%s" .Release.Name .Values.pushgateway.name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s-%s" .Release.Name $name .Values.pushgateway.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Get KubeVersion removing pre-release information.
*/}}
{{- define "prometheus.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version (regexFind "v[0-9]+\\.[0-9]+\\.[0-9]+" .Capabilities.KubeVersion.Version) -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for deployment.
*/}}
{{- define "prometheus.deployment.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}
{{/*
Return the appropriate apiVersion for daemonset.
*/}}
{{- define "prometheus.daemonset.apiVersion" -}}
{{- print "apps/v1" -}}
{{- end -}}
{{/*
Return the appropriate apiVersion for networkpolicy.
*/}}
{{- define "prometheus.networkPolicy.apiVersion" -}}
{{- print "networking.k8s.io/v1" -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for poddisruptionbudget.
*/}}
{{- define "prometheus.podDisruptionBudget.apiVersion" -}}
{{- if .Capabilities.APIVersions.Has "policy/v1" }}
{{- print "policy/v1" -}}
{{- else -}}
{{- print "policy/v1beta1" -}}
{{- end -}}
{{- end -}}
{{/*
Return the appropriate apiVersion for rbac.
*/}}
{{- define "rbac.apiVersion" -}}
{{- if .Capabilities.APIVersions.Has "rbac.authorization.k8s.io/v1" }}
{{- print "rbac.authorization.k8s.io/v1" -}}
{{- else -}}
{{- print "rbac.authorization.k8s.io/v1beta1" -}}
{{- end -}}
{{- end -}}
{{/*
Return the appropriate apiVersion for ingress.
*/}}
{{- define "ingress.apiVersion" -}}
  {{- if and (.Capabilities.APIVersions.Has "networking.k8s.io/v1") (semverCompare ">= 1.19.x" (include "prometheus.kubeVersion" .)) -}}
      {{- print "networking.k8s.io/v1" -}}
  {{- else if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1" -}}
    {{- print "networking.k8s.io/v1beta1" -}}
  {{- else -}}
    {{- print "extensions/v1beta1" -}}
  {{- end -}}
{{- end -}}

{{/*
Return if ingress is stable.
*/}}
{{- define "ingress.isStable" -}}
  {{- eq (include "ingress.apiVersion" .) "networking.k8s.io/v1" -}}
{{- end -}}

{{/*
Return if ingress supports ingressClassName.
*/}}
{{- define "ingress.supportsIngressClassName" -}}
  {{- or (eq (include "ingress.isStable" .) "true") (and (eq (include "ingress.apiVersion" .) "networking.k8s.io/v1beta1") (semverCompare ">= 1.18.x" (include "prometheus.kubeVersion" .))) -}}
{{- end -}}
{{/*
Return if ingress supports pathType.
*/}}
{{- define "ingress.supportsPathType" -}}
  {{- or (eq (include "ingress.isStable" .) "true") (and (eq (include "ingress.apiVersion" .) "networking.k8s.io/v1beta1") (semverCompare ">= 1.18.x" (include "prometheus.kubeVersion" .))) -}}
{{- end -}}

{{/*
Create the name of the service account to use for the nodeExporter component
*/}}
{{- define "prometheus.serviceAccountName.nodeExporter" -}}
{{- if .Values.serviceAccounts.nodeExporter.create -}}
    {{ default (include "prometheus.nodeExporter.fullname" .) .Values.serviceAccounts.nodeExporter.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.nodeExporter.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the pushgateway component
*/}}
{{- define "prometheus.serviceAccountName.pushgateway" -}}
{{- if .Values.serviceAccounts.pushgateway.create -}}
    {{ default (include "prometheus.pushgateway.fullname" .) .Values.serviceAccounts.pushgateway.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.pushgateway.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the server component
*/}}
{{- define "prometheus.serviceAccountName.server" -}}
{{- if .Values.serviceAccounts.server.create -}}
    {{ default (include "prometheus.server.fullname" .) .Values.serviceAccounts.server.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.server.name }}
{{- end -}}
{{- end -}}

{{/*
Define the prometheus.namespace template if set with forceNamespace or .Release.Namespace is set
*/}}
{{- define "prometheus.namespace" -}}
  {{- default .Release.Namespace .Values.forceNamespace -}}
{{- end }}

{{/* ==================================================================== */}}
{{/* ================ Kasten added code lives below here ================ */}}
{{/* ==================================================================== */}}

{{/*
  Get the ConfigMap Reload image
*/}}
{{- define "get.cmreloadimage" }}
  {{- (get .Values.global.images (include "prometheus.cmreloadImageName" .)) | default (include "prometheus.cmreloadImage" .)  }}
{{- end }}

{{- define "prometheus.cmreloadImage" }}
  {{- printf "%s:%s" (include "prometheus.cmreloadImageRepo" .) (include "prometheus.cmreloadImageTag" .) }}
{{- end -}}

{{- define "prometheus.cmreloadImageRepo" -}}
  {{- if .Values.global.airgapped.repository }}
    {{- printf "%s/%s" .Values.global.airgapped.repository (include "prometheus.cmreloadImageName" .) }}
  {{- else }}
    {{- printf "%s/%s" .Values.global.image.registry (include "prometheus.cmreloadImageName" .) }}
  {{- end }}
{{- end -}}

{{- define "prometheus.cmreloadImageName" -}}
  {{- printf "configmap-reload" }}
{{- end -}}

{{- define "prometheus.cmreloadImageTag" -}}
  {{- include "get.k10ImageTag" . }}
{{- end -}}

{{/*
  Get the Prometheus image
*/}}

{{- define "get.serverimage" }}
  {{- (get .Values.global.images (include "prometheus.prometheusImageName" .)) | default (include "prometheus.prometheusImage" .)  }}
{{- end -}}

{{- define "prometheus.prometheusImage" }}
  {{- printf "%s:%s" (include "prometheus.prometheusImageRepo" .) (include "prometheus.prometheusImageTag" .) }}
{{- end -}}

{{- define "prometheus.prometheusImageRepo" -}}
  {{- if .Values.global.airgapped.repository }}
    {{- printf "%s/%s" .Values.global.airgapped.repository (include "prometheus.prometheusImageName" .) }}
  {{- else }}
    {{- printf "%s/%s" .Values.global.image.registry (include "prometheus.prometheusImageName" .) }}
  {{- end }}
{{- end -}}

{{- define "prometheus.prometheusImageName" -}}
  {{- printf "prometheus" }}
{{- end -}}

{{- define "prometheus.prometheusImageTag" -}}
  {{- include "get.k10ImageTag" . }}
{{- end -}}

{{/*
Create a fully qualified Prometheus server clusterrole name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "prometheus.server.clusterrolefullname" -}}
  {{- if .Values.server.clusterRoleNameOverride -}}
    {{- .Values.server.clusterRoleNameOverride | trunc 63 | trimSuffix "-" -}}
  {{- else -}}
    {{- if .Values.server.fullnameOverride -}}
      {{- printf "%s-%s" .Release.Name .Values.server.fullnameOverride | trunc 63 | trimSuffix "-" -}}
    {{- else -}}
      {{- $name := default .Chart.Name .Values.nameOverride -}}
      {{- if contains $name .Release.Name -}}
        {{- printf "%s-%s" .Release.Name .Values.server.name | trunc 63 | trimSuffix "-" -}}
      {{- else -}}
        {{- printf "%s-%s-%s" .Release.Name $name .Values.server.name | trunc 63 | trimSuffix "-" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
