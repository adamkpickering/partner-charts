{{- /* Generated from "helpers.go" */ -}}

{{- define "redpanda.Chart" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- (dict "r" (get (fromJson (include "redpanda.cleanForK8s" (dict "a" (list (replace "+" "_" (printf "%s-%s" $dot.Chart.Name $dot.Chart.Version))) ))) "r")) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.Name" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $tmp_tuple_1 := (get (fromJson (include "_shims.compact" (dict "a" (list (get (fromJson (include "_shims.typetest" (dict "a" (list "string" (index $dot.Values "nameOverride") "") ))) "r")) ))) "r") -}}
{{- $ok_2 := $tmp_tuple_1.T2 -}}
{{- $override_1 := $tmp_tuple_1.T1 -}}
{{- if (and $ok_2 (ne $override_1 "")) -}}
{{- (dict "r" (get (fromJson (include "redpanda.cleanForK8s" (dict "a" (list $override_1) ))) "r")) | toJson -}}
{{- break -}}
{{- end -}}
{{- (dict "r" (get (fromJson (include "redpanda.cleanForK8s" (dict "a" (list $dot.Chart.Name) ))) "r")) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.Fullname" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $tmp_tuple_2 := (get (fromJson (include "_shims.compact" (dict "a" (list (get (fromJson (include "_shims.typetest" (dict "a" (list "string" (index $dot.Values "fullnameOverride") "") ))) "r")) ))) "r") -}}
{{- $ok_4 := $tmp_tuple_2.T2 -}}
{{- $override_3 := $tmp_tuple_2.T1 -}}
{{- if (and $ok_4 (ne $override_3 "")) -}}
{{- (dict "r" (get (fromJson (include "redpanda.cleanForK8s" (dict "a" (list $override_3) ))) "r")) | toJson -}}
{{- break -}}
{{- end -}}
{{- (dict "r" (get (fromJson (include "redpanda.cleanForK8s" (dict "a" (list (printf "%s" $dot.Release.Name)) ))) "r")) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.FullLabels" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $values := $dot.Values.AsMap -}}
{{- $labels := (dict ) -}}
{{- if (ne $values.commonLabels (coalesce nil)) -}}
{{- $labels = $values.commonLabels -}}
{{- end -}}
{{- $defaults := (dict "helm.sh/chart" (get (fromJson (include "redpanda.Chart" (dict "a" (list $dot) ))) "r") "app.kubernetes.io/name" (get (fromJson (include "redpanda.Name" (dict "a" (list $dot) ))) "r") "app.kubernetes.io/instance" $dot.Release.Name "app.kubernetes.io/managed-by" $dot.Release.Service "app.kubernetes.io/component" (get (fromJson (include "redpanda.Name" (dict "a" (list $dot) ))) "r") ) -}}
{{- (dict "r" (merge (dict ) $labels $defaults)) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.StatefulSetPodLabelsSelector" -}}
{{- $dot := (index .a 0) -}}
{{- $existing := (index .a 1) -}}
{{- range $_ := (list 1) -}}
{{- if (and $dot.Release.IsUpgrade (ne $existing (coalesce nil))) -}}
{{- if (gt (int (get (fromJson (include "_shims.len" (dict "a" (list $existing.spec.selector.matchLabels) ))) "r")) 0) -}}
{{- (dict "r" $existing.spec.selector.matchLabels) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}
{{- $values := $dot.Values.AsMap -}}
{{- $additionalSelectorLabels := (dict ) -}}
{{- if (ne $values.statefulset.additionalSelectorLabels (coalesce nil)) -}}
{{- $additionalSelectorLabels = $values.statefulset.additionalSelectorLabels -}}
{{- end -}}
{{- $component := (printf "%s-statefulset" (trimSuffix "-" (trunc 51 (get (fromJson (include "redpanda.Name" (dict "a" (list $dot) ))) "r")))) -}}
{{- $defaults := (dict "app.kubernetes.io/component" $component "app.kubernetes.io/instance" $dot.Release.Name "app.kubernetes.io/name" (get (fromJson (include "redpanda.Name" (dict "a" (list $dot) ))) "r") ) -}}
{{- (dict "r" (merge (dict ) $additionalSelectorLabels $defaults)) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.StatefulSetPodLabels" -}}
{{- $dot := (index .a 0) -}}
{{- $existing := (index .a 1) -}}
{{- range $_ := (list 1) -}}
{{- if (and $dot.Release.IsUpgrade (ne $existing (coalesce nil))) -}}
{{- if (gt (int (get (fromJson (include "_shims.len" (dict "a" (list $existing.spec.template.metadata.labels) ))) "r")) 0) -}}
{{- (dict "r" $existing.spec.template.metadata.labels) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}
{{- $values := $dot.Values.AsMap -}}
{{- $statefulSetLabels := (dict ) -}}
{{- if (ne $values.statefulset.podTemplate.labels (coalesce nil)) -}}
{{- $statefulSetLabels = $values.statefulset.podTemplate.labels -}}
{{- end -}}
{{- $defaults := (dict "redpanda.com/poddisruptionbudget" (get (fromJson (include "redpanda.Fullname" (dict "a" (list $dot) ))) "r") ) -}}
{{- (dict "r" (merge (dict ) $statefulSetLabels (get (fromJson (include "redpanda.StatefulSetPodLabelsSelector" (dict "a" (list $dot $existing) ))) "r") $defaults)) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.StatefulSetPodAnnotations" -}}
{{- $dot := (index .a 0) -}}
{{- $configMapChecksum := (index .a 1) -}}
{{- range $_ := (list 1) -}}
{{- $values := $dot.Values.AsMap -}}
{{- $configMapChecksumAnnotation := (dict "config.redpanda.com/checksum" $configMapChecksum ) -}}
{{- if (ne $values.statefulset.podTemplate.annotations (coalesce nil)) -}}
{{- (dict "r" (merge (dict ) $values.statefulset.podTemplate.annotations $configMapChecksumAnnotation)) | toJson -}}
{{- break -}}
{{- end -}}
{{- (dict "r" (merge (dict ) $values.statefulset.annotations $configMapChecksumAnnotation)) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.ServiceAccountName" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $values := $dot.Values.AsMap -}}
{{- $serviceAccount := $values.serviceAccount -}}
{{- if (and $serviceAccount.create (ne $serviceAccount.name "")) -}}
{{- (dict "r" $serviceAccount.name) | toJson -}}
{{- break -}}
{{- else -}}{{- if $serviceAccount.create -}}
{{- (dict "r" (get (fromJson (include "redpanda.Fullname" (dict "a" (list $dot) ))) "r")) | toJson -}}
{{- break -}}
{{- else -}}{{- if (ne $serviceAccount.name "") -}}
{{- (dict "r" $serviceAccount.name) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- (dict "r" "default") | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.Tag" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $values := $dot.Values.AsMap -}}
{{- $tag := (toString $values.image.tag) -}}
{{- if (eq $tag "") -}}
{{- $tag = $dot.Chart.AppVersion -}}
{{- end -}}
{{- $pattern := "^v(0|[1-9]\\d*)\\.(0|[1-9]\\d*)\\.(0|[1-9]\\d*)(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$" -}}
{{- if (not (regexMatch $pattern $tag)) -}}
{{- $_ := (fail "image.tag must start with a 'v' and be a valid semver") -}}
{{- end -}}
{{- (dict "r" $tag) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.ServiceName" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $values := $dot.Values.AsMap -}}
{{- if (and (ne $values.service (coalesce nil)) (ne $values.service.name (coalesce nil))) -}}
{{- (dict "r" (get (fromJson (include "redpanda.cleanForK8s" (dict "a" (list $values.service.name) ))) "r")) | toJson -}}
{{- break -}}
{{- end -}}
{{- (dict "r" (get (fromJson (include "redpanda.Fullname" (dict "a" (list $dot) ))) "r")) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.InternalDomain" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $values := $dot.Values.AsMap -}}
{{- $service := (get (fromJson (include "redpanda.ServiceName" (dict "a" (list $dot) ))) "r") -}}
{{- $ns := $dot.Release.Namespace -}}
{{- $domain := (trimSuffix "." $values.clusterDomain) -}}
{{- (dict "r" (printf "%s.%s.svc.%s." $service $ns $domain)) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.TLSEnabled" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $values := $dot.Values.AsMap -}}
{{- if (and (ne $values.tls.enabled (coalesce nil)) $values.tls.enabled) -}}
{{- (dict "r" true) | toJson -}}
{{- break -}}
{{- end -}}
{{- $listeners := (list "kafka" "admin" "schemaRegistry" "rpc" "http") -}}
{{- range $_, $listener := $listeners -}}
{{- $tlsCert := (dig "listeners" $listener "tls" "cert" false $dot.Values.AsMap) -}}
{{- $tlsEnabled := (dig "listeners" $listener "tls" "enabled" false $dot.Values.AsMap) -}}
{{- if (and (not (empty $tlsEnabled)) (not (empty $tlsCert))) -}}
{{- (dict "r" true) | toJson -}}
{{- break -}}
{{- end -}}
{{- $external := (dig "listeners" $listener "external" false $dot.Values.AsMap) -}}
{{- if (empty $external) -}}
{{- continue -}}
{{- end -}}
{{- $keys := (keys (get (fromJson (include "_shims.typeassertion" (dict "a" (list (printf "map[%s]%s" "string" "interface {}") $external) ))) "r")) -}}
{{- range $_, $key := $keys -}}
{{- $enabled := (dig "listeners" $listener "external" $key "enabled" false $dot.Values.AsMap) -}}
{{- $tlsCert := (dig "listeners" $listener "external" $key "tls" "cert" false $dot.Values.AsMap) -}}
{{- $tlsEnabled := (dig "listeners" $listener "external" $key "tls" "enabled" false $dot.Values.AsMap) -}}
{{- if (and (and (not (empty $enabled)) (not (empty $tlsCert))) (not (empty $tlsEnabled))) -}}
{{- (dict "r" true) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}
{{- end -}}
{{- (dict "r" false) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.ClientAuthRequired" -}}
{{- $dot := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- $listeners := (list "kafka" "admin" "schemaRegistry" "rpc" "http") -}}
{{- range $_, $listener := $listeners -}}
{{- $required := (dig $listener "tls" "requireClientAuth" false $dot.Values.AsMap) -}}
{{- if (not (empty $required)) -}}
{{- (dict "r" true) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}
{{- (dict "r" false) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

{{- define "redpanda.cleanForK8s" -}}
{{- $in := (index .a 0) -}}
{{- range $_ := (list 1) -}}
{{- (dict "r" (trimSuffix "-" (trunc 63 $in))) | toJson -}}
{{- break -}}
{{- end -}}
{{- end -}}

