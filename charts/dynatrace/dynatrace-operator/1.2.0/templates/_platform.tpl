// Copyright 2020 Dynatrace LLC

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//     http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

{{/*
Auto-detect the platform (if not set), according to the available APIVersions
*/}}
{{- define "dynatrace-operator.platform" -}}
    {{- if .Values.platform}}
        {{- printf .Values.platform -}}
    {{- else if .Capabilities.APIVersions.Has "security.openshift.io/v1" }}
        {{- printf "openshift" -}}
    {{- else }}
        {{- printf "kubernetes" -}}
    {{- end -}}
{{- end }}

{{/*
Exclude Kubernetes manifest not running on OLM
*/}}
{{- define "dynatrace-operator.openshiftOrOlm" -}}
{{- if and (or (eq (include "dynatrace-operator.platform" .) "openshift") (.Values.olm)) (eq (include "dynatrace-operator.partial" .) "false") -}}
    {{ default "true" }}
{{- end -}}
{{- end -}}

{{/*
Check if platform is set to a valid one
*/}}
{{- define "dynatrace-operator.platformIsValid" -}}
{{- $validPlatforms := list "kubernetes" "openshift" "google-marketplace" "gke-autopilot" "azure-marketplace" -}}
{{- if has (include "dynatrace-operator.platform" .) $validPlatforms -}}
    {{ default "set" }}
{{- end -}}
{{- end -}}

{{/*
Enforces that platform is set to a valid one
*/}}
{{- define "dynatrace-operator.platformRequired" -}}
{{- $platformIsSet := printf "%s" (required "Platform needs to be set to kubernetes, openshift, google-marketplace, or gke-autopilot" (include "dynatrace-operator.platformIsValid" .))}}
{{- end -}}

{{- define "dynatrace-operator.nodeAffinity" -}}
affinity:
  nodeAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      nodeSelectorTerms:
        - matchExpressions:
            - key: kubernetes.io/arch
              operator: In
              values:
                - amd64
                - arm64
                - ppc64le
                - s390x
            - key: kubernetes.io/os
              operator: In
              values:
                - linux
{{- end -}}

{{- define "dynatrace-operator.defaultTolerations" -}}
- key: kubernetes.io/arch
  value: arm64
  effect: NoSchedule
- key: kubernetes.io/arch
  value: amd64
  effect: NoSchedule
- key: kubernetes.io/arch
  value: ppc64le
  effect: NoSchedule
- key: kubernetes.io/arch
  value: s390x
  effect: NoSchedule
{{- end -}}
