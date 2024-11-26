# traefik

![Version: 33.0.0](https://img.shields.io/badge/Version-33.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v3.2.0](https://img.shields.io/badge/AppVersion-v3.2.0-informational?style=flat-square)

A Traefik based Kubernetes ingress controller

**Homepage:** <https://traefik.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| mloiseleur | <michel.loiseleur@traefik.io> |  |
| charlie-haley | <charlie.haley@traefik.io> |  |
| darkweaver87 | <remi.buisson@traefik.io> |  |
| jnoordsij |  |  |

## Source Code

* <https://github.com/traefik/traefik>
* <https://github.com/traefik/traefik-helm-chart>

## Requirements

Kubernetes: `>=1.22.0-0`

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalArguments | list | `[]` | Additional arguments to be passed at Traefik's binary See [CLI Reference](https://docs.traefik.io/reference/static-configuration/cli/) Use curly braces to pass values: `helm install --set="additionalArguments={--providers.kubernetesingress.ingressclass=traefik-internal,--log.level=DEBUG}"` |
| additionalVolumeMounts | list | `[]` | Additional volumeMounts to add to the Traefik container |
| affinity | object | `{}` | on nodes where no other traefik pods are scheduled. It should be used when hostNetwork: true to prevent port conflicts |
| autoscaling.enabled | bool | `false` | Create HorizontalPodAutoscaler object. See EXAMPLES.md for more details. |
| certificatesResolvers | object | `{}` | Certificates resolvers configuration. Ref: https://doc.traefik.io/traefik/https/acme/#certificate-resolvers See EXAMPLES.md for more details. |
| commonLabels | object | `{}` | Add additional label to all resources |
| core.defaultRuleSyntax | string | `""` | Can be used to use globally v2 router syntax See https://doc.traefik.io/traefik/v3.0/migration/v2-to-v3/#new-v3-syntax-notable-changes |
| deployment.additionalContainers | list | `[]` | Additional containers (e.g. for metric offloading sidecars) |
| deployment.additionalVolumes | list | `[]` | Additional volumes available for use with initContainers and additionalContainers |
| deployment.annotations | object | `{}` | Additional deployment annotations (e.g. for jaeger-operator sidecar injection) |
| deployment.dnsConfig | object | `{}` | Custom pod [DNS config](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.30/#poddnsconfig-v1-core) |
| deployment.dnsPolicy | string | `""` | Custom pod DNS policy. Apply if `hostNetwork: true` |
| deployment.enabled | bool | `true` | Enable deployment |
| deployment.healthchecksHost | string | `""` |  |
| deployment.healthchecksPort | string | `nil` |  |
| deployment.healthchecksScheme | string | `nil` |  |
| deployment.hostAliases | list | `[]` | Custom [host aliases](https://kubernetes.io/docs/tasks/network/customize-hosts-file-for-pods/) |
| deployment.imagePullSecrets | list | `[]` | Pull secret for fetching traefik container image |
| deployment.initContainers | list | `[]` | Additional initContainers (e.g. for setting file permission as shown below) |
| deployment.kind | string | `"Deployment"` | Deployment or DaemonSet |
| deployment.labels | object | `{}` | Additional deployment labels (e.g. for filtering deployment by custom labels) |
| deployment.lifecycle | object | `{}` | Pod lifecycle actions |
| deployment.livenessPath | string | `""` | Override the liveness path. Default: /ping |
| deployment.minReadySeconds | int | `0` | The minimum number of seconds Traefik needs to be up and running before the DaemonSet/Deployment controller considers it available |
| deployment.podAnnotations | object | `{}` | Additional pod annotations (e.g. for mesh injection or prometheus scraping) It supports templating. One can set it with values like traefik/name: '{{ template "traefik.name" . }}' |
| deployment.podLabels | object | `{}` | Additional Pod labels (e.g. for filtering Pod by custom labels) |
| deployment.readinessPath | string | `""` |  |
| deployment.replicas | int | `1` | Number of pods of the deployment (only applies when kind == Deployment) |
| deployment.revisionHistoryLimit | string | `nil` | Number of old history to retain to allow rollback (If not set, default Kubernetes value is set to 10) |
| deployment.runtimeClassName | string | `""` | Set a runtimeClassName on pod |
| deployment.shareProcessNamespace | bool | `false` | Use process namespace sharing |
| deployment.terminationGracePeriodSeconds | int | `60` | Amount of time (in seconds) before Kubernetes will send the SIGKILL signal if Traefik does not shut down |
| env | list | See _values.yaml_ | Additional Environment variables to be passed to Traefik's binary |
| envFrom | list | `[]` | Environment variables to be passed to Traefik's binary from configMaps or secrets |
| experimental.kubernetesGateway.enabled | bool | `false` | Enable traefik experimental GatewayClass CRD |
| experimental.plugins | object | `{}` | Enable traefik experimental plugins |
| extraObjects | list | `[]` | Extra objects to deploy (value evaluated as a template)  In some cases, it can avoid the need for additional, extended or adhoc deployments. See #595 for more details and traefik/tests/values/extra.yaml for example. |
| gateway.annotations | object | `{}` | Additional gateway annotations (e.g. for cert-manager.io/issuer) |
| gateway.enabled | bool | `true` | When providers.kubernetesGateway.enabled, deploy a default gateway |
| gateway.infrastructure | object | `{}` | [Infrastructure](https://kubernetes.io/blog/2023/11/28/gateway-api-ga/#gateway-infrastructure-labels) |
| gateway.listeners | object | `{"web":{"hostname":"","namespacePolicy":null,"port":8000,"protocol":"HTTP"}}` | Define listeners |
| gateway.listeners.web.hostname | string | `""` | Optional hostname. See [Hostname](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.Hostname) |
| gateway.listeners.web.namespacePolicy | string | `nil` | Routes are restricted to namespace of the gateway [by default](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1.FromNamespaces |
| gateway.listeners.web.port | int | `8000` | Port is the network port. Multiple listeners may use the same port, subject to the Listener compatibility rules. The port must match a port declared in ports section. |
| gateway.name | string | `""` | Set a custom name to gateway |
| gateway.namespace | string | `""` | By default, Gateway is created in the same `Namespace` than Traefik. |
| gatewayClass.enabled | bool | `true` | When providers.kubernetesGateway.enabled and gateway.enabled, deploy a default gatewayClass |
| gatewayClass.labels | object | `{}` | Additional gatewayClass labels (e.g. for filtering gateway objects by custom labels) |
| gatewayClass.name | string | `""` | Set a custom name to GatewayClass |
| globalArguments | list | `["--global.checknewversion","--global.sendanonymoususage"]` | Global command arguments to be passed to all traefik's pods |
| hostNetwork | bool | `false` | If hostNetwork is true, runs traefik in the host network namespace To prevent unschedulabel pods due to port collisions, if hostNetwork=true and replicas>1, a pod anti-affinity is recommended and will be set if the affinity is left as default. |
| hub.apimanagement.admission.listenAddr | string | `""` | WebHook admission server listen address. Default: "0.0.0.0:9943". |
| hub.apimanagement.admission.secretName | string | `""` | Certificate of the WebHook admission server. Default: "hub-agent-cert". |
| hub.apimanagement.enabled | bool | `false` | Set to true in order to enable API Management. Requires a valid license token. |
| hub.redis.cluster | string | `nil` | Enable Redis Cluster. Default: true. |
| hub.redis.database | string | `nil` | Database used to store information. Default: "0". |
| hub.redis.endpoints | string | `""` | Endpoints of the Redis instances to connect to. Default: "". |
| hub.redis.password | string | `""` | The password to use when connecting to Redis endpoints. Default: "". |
| hub.redis.sentinel.masterset | string | `""` | Name of the set of main nodes to use for main selection. Required when using Sentinel. Default: "". |
| hub.redis.sentinel.password | string | `""` | Password to use for sentinel authentication (can be different from endpoint password). Default: "". |
| hub.redis.sentinel.username | string | `""` | Username to use for sentinel authentication (can be different from endpoint username). Default: "". |
| hub.redis.timeout | string | `""` | Timeout applied on connection with redis. Default: "0s". |
| hub.redis.tls.ca | string | `""` | Path to the certificate authority used for the secured connection. |
| hub.redis.tls.cert | string | `""` | Path to the public certificate used for the secure connection. |
| hub.redis.tls.insecureSkipVerify | bool | `false` | When insecureSkipVerify is set to true, the TLS connection accepts any certificate presented by the server. Default: false. |
| hub.redis.tls.key | string | `""` | Path to the private key used for the secure connection. |
| hub.redis.username | string | `""` | The username to use when connecting to Redis endpoints. Default: "". |
| hub.sendlogs | string | `nil` |  |
| hub.token | string | `""` | Name of `Secret` with key 'token' set to a valid license token. It enables API Gateway. |
| image.pullPolicy | string | `"IfNotPresent"` | Traefik image pull policy |
| image.registry | string | `"docker.io"` | Traefik image host registry |
| image.repository | string | `"traefik"` | Traefik image repository |
| image.tag | string | `nil` | defaults to appVersion |
| ingressClass | object | `{"enabled":true,"isDefaultClass":true,"name":""}` | Create a default IngressClass for Traefik |
| ingressRoute.dashboard.annotations | object | `{}` | Additional ingressRoute annotations (e.g. for kubernetes.io/ingress.class) |
| ingressRoute.dashboard.enabled | bool | `false` | Create an IngressRoute for the dashboard |
| ingressRoute.dashboard.entryPoints | list | `["traefik"]` | Specify the allowed entrypoints to use for the dashboard ingress route, (e.g. traefik, web, websecure). By default, it's using traefik entrypoint, which is not exposed. /!\ Do not expose your dashboard without any protection over the internet /!\ |
| ingressRoute.dashboard.labels | object | `{}` | Additional ingressRoute labels (e.g. for filtering IngressRoute by custom labels) |
| ingressRoute.dashboard.matchRule | string | `"PathPrefix(`/dashboard`) || PathPrefix(`/api`)"` | The router match rule used for the dashboard ingressRoute |
| ingressRoute.dashboard.middlewares | list | `[]` | Additional ingressRoute middlewares (e.g. for authentication) |
| ingressRoute.dashboard.services | list | `[{"kind":"TraefikService","name":"api@internal"}]` | The internal service used for the dashboard ingressRoute |
| ingressRoute.dashboard.tls | object | `{}` | TLS options (e.g. secret containing certificate) |
| ingressRoute.healthcheck.annotations | object | `{}` | Additional ingressRoute annotations (e.g. for kubernetes.io/ingress.class) |
| ingressRoute.healthcheck.enabled | bool | `false` | Create an IngressRoute for the healthcheck probe |
| ingressRoute.healthcheck.entryPoints | list | `["traefik"]` | Specify the allowed entrypoints to use for the healthcheck ingress route, (e.g. traefik, web, websecure). By default, it's using traefik entrypoint, which is not exposed. |
| ingressRoute.healthcheck.labels | object | `{}` | Additional ingressRoute labels (e.g. for filtering IngressRoute by custom labels) |
| ingressRoute.healthcheck.matchRule | string | `"PathPrefix(`/ping`)"` | The router match rule used for the healthcheck ingressRoute |
| ingressRoute.healthcheck.middlewares | list | `[]` | Additional ingressRoute middlewares (e.g. for authentication) |
| ingressRoute.healthcheck.services | list | `[{"kind":"TraefikService","name":"ping@internal"}]` | The internal service used for the healthcheck ingressRoute |
| ingressRoute.healthcheck.tls | object | `{}` | TLS options (e.g. secret containing certificate) |
| instanceLabelOverride | string | `""` |  |
| livenessProbe.failureThreshold | int | `3` | The number of consecutive failures allowed before considering the probe as failed. |
| livenessProbe.initialDelaySeconds | int | `2` | The number of seconds to wait before starting the first probe. |
| livenessProbe.periodSeconds | int | `10` | The number of seconds to wait between consecutive probes. |
| livenessProbe.successThreshold | int | `1` | The minimum consecutive successes required to consider the probe successful. |
| livenessProbe.timeoutSeconds | int | `2` | The number of seconds to wait for a probe response before considering it as failed. |
| logs.access.addInternals | bool | `false` | Enables accessLogs for internal resources. Default: false. |
| logs.access.bufferingSize | string | `nil` | Set [bufferingSize](https://doc.traefik.io/traefik/observability/access-logs/#bufferingsize) |
| logs.access.enabled | bool | `false` | To enable access logs |
| logs.access.fields.general.defaultmode | string | `"keep"` | Set default mode for fields.names |
| logs.access.fields.general.names | object | `{}` | Names of the fields to limit. |
| logs.access.fields.headers | object | `{"defaultmode":"drop","names":{}}` | [Limit logged fields or headers](https://doc.traefik.io/traefik/observability/access-logs/#limiting-the-fieldsincluding-headers) |
| logs.access.fields.headers.defaultmode | string | `"drop"` | Set default mode for fields.headers |
| logs.access.filters | object | `{"minduration":"","retryattempts":false,"statuscodes":""}` | Set [filtering](https://docs.traefik.io/observability/access-logs/#filtering) |
| logs.access.filters.minduration | string | `""` | Set minDuration, to keep access logs when requests take longer than the specified duration |
| logs.access.filters.retryattempts | bool | `false` | Set retryAttempts, to keep the access logs when at least one retry has happened |
| logs.access.filters.statuscodes | string | `""` | Set statusCodes, to limit the access logs to requests with a status codes in the specified range |
| logs.access.format | string | `nil` | Set [access log format](https://doc.traefik.io/traefik/observability/access-logs/#format) |
| logs.general.filePath | string | `""` | To write the logs into a log file, use the filePath option. |
| logs.general.format | string | `nil` | Set [logs format](https://doc.traefik.io/traefik/observability/logs/#format) |
| logs.general.level | string | `"INFO"` | Alternative logging levels are TRACE, DEBUG, INFO, WARN, ERROR, FATAL, and PANIC. |
| logs.general.noColor | bool | `false` | When set to true and format is common, it disables the colorized output. |
| metrics.addInternals | bool | `false` |  |
| metrics.otlp.addEntryPointsLabels | string | `nil` | Enable metrics on entry points. Default: true |
| metrics.otlp.addRoutersLabels | string | `nil` | Enable metrics on routers. Default: false |
| metrics.otlp.addServicesLabels | string | `nil` | Enable metrics on services. Default: true |
| metrics.otlp.enabled | bool | `false` | Set to true in order to enable the OpenTelemetry metrics |
| metrics.otlp.explicitBoundaries | list | `[]` | Explicit boundaries for Histogram data points. Default: [.005, .01, .025, .05, .1, .25, .5, 1, 2.5, 5, 10] |
| metrics.otlp.grpc.enabled | bool | `false` | Set to true in order to send metrics to the OpenTelemetry Collector using gRPC |
| metrics.otlp.grpc.endpoint | string | `""` | Format: <scheme>://<host>:<port><path>. Default: http://localhost:4318/v1/metrics |
| metrics.otlp.grpc.insecure | bool | `false` | Allows reporter to send metrics to the OpenTelemetry Collector without using a secured protocol. |
| metrics.otlp.grpc.tls.ca | string | `""` | The path to the certificate authority, it defaults to the system bundle. |
| metrics.otlp.grpc.tls.cert | string | `""` | The path to the public certificate. When using this option, setting the key option is required. |
| metrics.otlp.grpc.tls.insecureSkipVerify | bool | `false` | When set to true, the TLS connection accepts any certificate presented by the server regardless of the hostnames it covers. |
| metrics.otlp.grpc.tls.key | string | `""` | The path to the private key. When using this option, setting the cert option is required. |
| metrics.otlp.http.enabled | bool | `false` | Set to true in order to send metrics to the OpenTelemetry Collector using HTTP. |
| metrics.otlp.http.endpoint | string | `""` | Format: <scheme>://<host>:<port><path>. Default: http://localhost:4318/v1/metrics |
| metrics.otlp.http.headers | object | `{}` | Additional headers sent with metrics by the reporter to the OpenTelemetry Collector. |
| metrics.otlp.http.tls.ca | string | `""` | The path to the certificate authority, it defaults to the system bundle. |
| metrics.otlp.http.tls.cert | string | `""` | The path to the public certificate. When using this option, setting the key option is required. |
| metrics.otlp.http.tls.insecureSkipVerify | string | `nil` | When set to true, the TLS connection accepts any certificate presented by the server regardless of the hostnames it covers. |
| metrics.otlp.http.tls.key | string | `""` | The path to the private key. When using this option, setting the cert option is required. |
| metrics.otlp.pushInterval | string | `""` | Interval at which metrics are sent to the OpenTelemetry Collector. Default: 10s |
| metrics.prometheus.addEntryPointsLabels | string | `nil` |  |
| metrics.prometheus.addRoutersLabels | string | `nil` |  |
| metrics.prometheus.addServicesLabels | string | `nil` |  |
| metrics.prometheus.buckets | string | `""` |  |
| metrics.prometheus.disableAPICheck | string | `nil` | When set to true, it won't check if Prometheus Operator CRDs are deployed |
| metrics.prometheus.entryPoint | string | `"metrics"` | Entry point used to expose metrics. |
| metrics.prometheus.manualRouting | bool | `false` |  |
| metrics.prometheus.prometheusRule.additionalLabels | object | `{}` |  |
| metrics.prometheus.prometheusRule.enabled | bool | `false` | Enable optional CR for Prometheus Operator. See EXAMPLES.md for more details. |
| metrics.prometheus.prometheusRule.namespace | string | `""` |  |
| metrics.prometheus.service.annotations | object | `{}` |  |
| metrics.prometheus.service.enabled | bool | `false` | Create a dedicated metrics service to use with ServiceMonitor |
| metrics.prometheus.service.labels | object | `{}` |  |
| metrics.prometheus.serviceMonitor.additionalLabels | object | `{}` |  |
| metrics.prometheus.serviceMonitor.enableHttp2 | bool | `false` |  |
| metrics.prometheus.serviceMonitor.enabled | bool | `false` | Enable optional CR for Prometheus Operator. See EXAMPLES.md for more details. |
| metrics.prometheus.serviceMonitor.followRedirects | bool | `false` |  |
| metrics.prometheus.serviceMonitor.honorLabels | bool | `false` |  |
| metrics.prometheus.serviceMonitor.honorTimestamps | bool | `false` |  |
| metrics.prometheus.serviceMonitor.interval | string | `""` |  |
| metrics.prometheus.serviceMonitor.jobLabel | string | `""` |  |
| metrics.prometheus.serviceMonitor.metricRelabelings | list | `[]` |  |
| metrics.prometheus.serviceMonitor.namespace | string | `""` |  |
| metrics.prometheus.serviceMonitor.namespaceSelector | object | `{}` |  |
| metrics.prometheus.serviceMonitor.relabelings | list | `[]` |  |
| metrics.prometheus.serviceMonitor.scrapeTimeout | string | `""` |  |
| namespaceOverride | string | `""` | This field override the default Release Namespace for Helm. It will not affect optional CRDs such as `ServiceMonitor` and `PrometheusRules` |
| nodeSelector | object | `{}` | nodeSelector is the simplest recommended form of node selection constraint. |
| persistence.accessMode | string | `"ReadWriteOnce"` |  |
| persistence.annotations | object | `{}` |  |
| persistence.enabled | bool | `false` | Enable persistence using Persistent Volume Claims ref: http://kubernetes.io/docs/user-guide/persistent-volumes/. It can be used to store TLS certificates along with `certificatesResolvers.<name>.acme.storage`  option |
| persistence.existingClaim | string | `""` |  |
| persistence.name | string | `"data"` |  |
| persistence.path | string | `"/data"` |  |
| persistence.size | string | `"128Mi"` |  |
| persistence.storageClass | string | `""` |  |
| persistence.subPath | string | `""` | Only mount a subpath of the Volume into the pod |
| persistence.volumeName | string | `""` |  |
| podDisruptionBudget | object | `{"enabled":false,"maxUnavailable":null,"minAvailable":null}` | [Pod Disruption Budget](https://kubernetes.io/docs/reference/kubernetes-api/policy-resources/pod-disruption-budget-v1/) |
| podSecurityContext | object | See _values.yaml_ | [Pod Security Context](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context) |
| podSecurityPolicy | object | `{"enabled":false}` | Enable to create a PodSecurityPolicy and assign it to the Service Account via RoleBinding or ClusterRoleBinding |
| ports.metrics.expose | object | `{"default":false}` | You may not want to expose the metrics port on production deployments. If you want to access it from outside your cluster, use `kubectl port-forward` or create a secure ingress |
| ports.metrics.exposedPort | int | `9100` | The exposed port for this service |
| ports.metrics.port | int | `9100` | When using hostNetwork, use another port to avoid conflict with node exporter: https://github.com/prometheus/prometheus/wiki/Default-port-allocations |
| ports.metrics.protocol | string | `"TCP"` | The port protocol (TCP/UDP) |
| ports.traefik.expose | object | `{"default":false}` | You SHOULD NOT expose the traefik port on production deployments. If you want to access it from outside your cluster, use `kubectl port-forward` or create a secure ingress |
| ports.traefik.exposedPort | int | `8080` | The exposed port for this service |
| ports.traefik.hostIP | string | `nil` | Use hostIP if set. If not set, Kubernetes will default to 0.0.0.0, which means it's listening on all your interfaces and all your IPs. You may want to set this value if you need traefik to listen on specific interface only. |
| ports.traefik.hostPort | string | `nil` | Use hostPort if set. |
| ports.traefik.port | int | `8080` |  |
| ports.traefik.protocol | string | `"TCP"` | The port protocol (TCP/UDP) |
| ports.web.expose.default | bool | `true` |  |
| ports.web.exposedPort | int | `80` |  |
| ports.web.forwardedHeaders.insecure | bool | `false` |  |
| ports.web.forwardedHeaders.trustedIPs | list | `[]` | Trust forwarded headers information (X-Forwarded-*). |
| ports.web.nodePort | string | `nil` | See [upstream documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| ports.web.port | int | `8000` |  |
| ports.web.protocol | string | `"TCP"` |  |
| ports.web.proxyProtocol.insecure | bool | `false` |  |
| ports.web.proxyProtocol.trustedIPs | list | `[]` | Enable the Proxy Protocol header parsing for the entry point |
| ports.web.redirectTo | object | `{}` |  |
| ports.web.targetPort | string | `nil` |  |
| ports.web.transport | object | `{"keepAliveMaxRequests":null,"keepAliveMaxTime":null,"lifeCycle":{"graceTimeOut":null,"requestAcceptGraceTimeout":null},"respondingTimeouts":{"idleTimeout":null,"readTimeout":null,"writeTimeout":null}}` | Set transport settings for the entrypoint; see also https://doc.traefik.io/traefik/routing/entrypoints/#transport |
| ports.websecure.allowACMEByPass | bool | `false` | See [upstream documentation](https://doc.traefik.io/traefik/routing/entrypoints/#allowacmebypass) |
| ports.websecure.appProtocol | string | `nil` | See [upstream documentation](https://kubernetes.io/docs/concepts/services-networking/service/#application-protocol) |
| ports.websecure.containerPort | string | `nil` |  |
| ports.websecure.expose.default | bool | `true` |  |
| ports.websecure.exposedPort | int | `443` |  |
| ports.websecure.forwardedHeaders.insecure | bool | `false` |  |
| ports.websecure.forwardedHeaders.trustedIPs | list | `[]` | Trust forwarded headers information (X-Forwarded-*). |
| ports.websecure.hostPort | string | `nil` |  |
| ports.websecure.http3.advertisedPort | string | `nil` |  |
| ports.websecure.http3.enabled | bool | `false` |  |
| ports.websecure.middlewares | list | `[]` | /!\ It introduces here a link between your static configuration and your dynamic configuration /!\ It follows the provider naming convention: https://doc.traefik.io/traefik/providers/overview/#provider-namespace   - namespace-name1@kubernetescrd   - namespace-name2@kubernetescrd |
| ports.websecure.nodePort | string | `nil` | See [upstream documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport) |
| ports.websecure.port | int | `8443` |  |
| ports.websecure.protocol | string | `"TCP"` |  |
| ports.websecure.proxyProtocol.insecure | bool | `false` |  |
| ports.websecure.proxyProtocol.trustedIPs | list | `[]` | Enable the Proxy Protocol header parsing for the entry point |
| ports.websecure.targetPort | string | `nil` |  |
| ports.websecure.tls | object | `{"certResolver":"","domains":[],"enabled":true,"options":""}` | See [upstream documentation](https://doc.traefik.io/traefik/routing/entrypoints/#tls) |
| ports.websecure.transport | object | `{"keepAliveMaxRequests":null,"keepAliveMaxTime":null,"lifeCycle":{"graceTimeOut":null,"requestAcceptGraceTimeout":null},"respondingTimeouts":{"idleTimeout":null,"readTimeout":null,"writeTimeout":null}}` | See [upstream documentation](https://doc.traefik.io/traefik/routing/entrypoints/#transport) |
| priorityClassName | string | `""` | [Pod Priority and Preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/) |
| providers.file.content | string | `""` | File content (YAML format, go template supported) (see https://doc.traefik.io/traefik/providers/file/) |
| providers.file.enabled | bool | `false` | Create a file provider |
| providers.file.watch | bool | `true` | Allows Traefik to automatically watch for file changes |
| providers.kubernetesCRD.allowCrossNamespace | bool | `false` | Allows IngressRoute to reference resources in namespace other than theirs |
| providers.kubernetesCRD.allowEmptyServices | bool | `true` | Allows to return 503 when there is no endpoints available |
| providers.kubernetesCRD.allowExternalNameServices | bool | `false` | Allows to reference ExternalName services in IngressRoute |
| providers.kubernetesCRD.enabled | bool | `true` | Load Kubernetes IngressRoute provider |
| providers.kubernetesCRD.ingressClass | string | `""` | When the parameter is set, only resources containing an annotation with the same value are processed. Otherwise, resources missing the annotation, having an empty value, or the value traefik are processed. It will also set required annotation on Dashboard and Healthcheck IngressRoute when enabled. |
| providers.kubernetesCRD.namespaces | list | `[]` | Array of namespaces to watch. If left empty, Traefik watches all namespaces. |
| providers.kubernetesCRD.nativeLBByDefault | bool | `false` | Defines whether to use Native Kubernetes load-balancing mode by default. |
| providers.kubernetesGateway.enabled | bool | `false` | Enable Traefik Gateway provider for Gateway API |
| providers.kubernetesGateway.experimentalChannel | bool | `false` | Toggles support for the Experimental Channel resources (Gateway API release channels documentation). This option currently enables support for TCPRoute and TLSRoute. |
| providers.kubernetesGateway.labelselector | string | `""` | A label selector can be defined to filter on specific GatewayClass objects only. |
| providers.kubernetesGateway.namespaces | list | `[]` | Array of namespaces to watch. If left empty, Traefik watches all namespaces. |
| providers.kubernetesGateway.statusAddress.hostname | string | `""` | This Hostname will get copied to the Gateway status.addresses. |
| providers.kubernetesGateway.statusAddress.ip | string | `""` | This IP will get copied to the Gateway status.addresses, and currently only supports one IP value (IPv4 or IPv6). |
| providers.kubernetesGateway.statusAddress.service | object | `{"name":"{{ (include \"traefik.fullname\" .) }}","namespace":"{{ .Release.Namespace }}"}` | The Kubernetes service to copy status addresses from. When using third parties tools like External-DNS, this option can be used to copy the service loadbalancer.status (containing the service's endpoints IPs) to the gateways. Default to Service of this Chart. |
| providers.kubernetesIngress.allowEmptyServices | bool | `true` | Allows to return 503 when there is no endpoints available |
| providers.kubernetesIngress.allowExternalNameServices | bool | `false` | Allows to reference ExternalName services in Ingress |
| providers.kubernetesIngress.enabled | bool | `true` | Load Kubernetes Ingress provider |
| providers.kubernetesIngress.ingressClass | string | `nil` | When ingressClass is set, only Ingresses containing an annotation with the same value are processed. Otherwise, Ingresses missing the annotation, having an empty value, or the value traefik are processed. |
| providers.kubernetesIngress.namespaces | list | `[]` | Array of namespaces to watch. If left empty, Traefik watches all namespaces. |
| providers.kubernetesIngress.nativeLBByDefault | bool | `false` | Defines whether to use Native Kubernetes load-balancing mode by default. |
| providers.kubernetesIngress.publishedService.enabled | bool | `true` | Enable [publishedService](https://doc.traefik.io/traefik/providers/kubernetes-ingress/#publishedservice) |
| providers.kubernetesIngress.publishedService.pathOverride | string | `""` | Override path of Kubernetes Service used to copy status from. Format: namespace/servicename. Default to Service deployed with this Chart. |
| rbac | object | `{"aggregateTo":[],"enabled":true,"namespaced":false,"secretResourceNames":[]}` | Whether Role Based Access Control objects like roles and rolebindings should be created |
| readinessProbe.failureThreshold | int | `1` | The number of consecutive failures allowed before considering the probe as failed. |
| readinessProbe.initialDelaySeconds | int | `2` | The number of seconds to wait before starting the first probe. |
| readinessProbe.periodSeconds | int | `10` | The number of seconds to wait between consecutive probes. |
| readinessProbe.successThreshold | int | `1` | The minimum consecutive successes required to consider the probe successful. |
| readinessProbe.timeoutSeconds | int | `2` | The number of seconds to wait for a probe response before considering it as failed. |
| resources | object | `{}` | [Resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/) for `traefik` container. |
| securityContext | object | See _values.yaml_ | [SecurityContext](https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/pod-v1/#security-context-1) |
| service.additionalServices | object | `{}` |  |
| service.annotations | object | `{}` | Additional annotations applied to both TCP and UDP services (e.g. for cloud provider specific config) |
| service.annotationsTCP | object | `{}` | Additional annotations for TCP service only |
| service.annotationsUDP | object | `{}` | Additional annotations for UDP service only |
| service.enabled | bool | `true` |  |
| service.externalIPs | list | `[]` |  |
| service.labels | object | `{}` | Additional service labels (e.g. for filtering Service by custom labels) |
| service.loadBalancerSourceRanges | list | `[]` |  |
| service.single | bool | `true` |  |
| service.spec | object | `{}` | Cannot contain type, selector or ports entries. |
| service.type | string | `"LoadBalancer"` |  |
| serviceAccount | object | `{"name":""}` | The service account the pods will use to interact with the Kubernetes API |
| serviceAccountAnnotations | object | `{}` | Additional serviceAccount annotations (e.g. for oidc authentication) |
| startupProbe | object | `{}` | Define [Startup Probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#define-startup-probes) |
| tlsOptions | object | `{}` | TLS Options are created as [TLSOption CRDs](https://doc.traefik.io/traefik/https/tls/#tls-options) When using `labelSelector`, you'll need to set labels on tlsOption accordingly. See EXAMPLE.md for details. |
| tlsStore | object | `{}` | TLS Store are created as [TLSStore CRDs](https://doc.traefik.io/traefik/https/tls/#default-certificate). This is useful if you want to set a default certificate. See EXAMPLE.md for details. |
| tolerations | list | `[]` | Tolerations allow the scheduler to schedule pods with matching taints. |
| topologySpreadConstraints | list | `[]` | You can use topology spread constraints to control how Pods are spread across your cluster among failure-domains. |
| tracing | object | `{"addInternals":false,"otlp":{"enabled":false,"grpc":{"enabled":false,"endpoint":"","insecure":false,"tls":{"ca":"","cert":"","insecureSkipVerify":false,"key":""}},"http":{"enabled":false,"endpoint":"","headers":{},"tls":{"ca":"","cert":"","insecureSkipVerify":false,"key":""}}}}` | https://doc.traefik.io/traefik/observability/tracing/overview/ |
| tracing.addInternals | bool | `false` | Enables tracing for internal resources. Default: false. |
| tracing.otlp.enabled | bool | `false` | See https://doc.traefik.io/traefik/v3.0/observability/tracing/opentelemetry/ |
| tracing.otlp.grpc.enabled | bool | `false` | Set to true in order to send metrics to the OpenTelemetry Collector using gRPC |
| tracing.otlp.grpc.endpoint | string | `""` | Format: <scheme>://<host>:<port><path>. Default: http://localhost:4318/v1/metrics |
| tracing.otlp.grpc.insecure | bool | `false` | Allows reporter to send metrics to the OpenTelemetry Collector without using a secured protocol. |
| tracing.otlp.grpc.tls.ca | string | `""` | The path to the certificate authority, it defaults to the system bundle. |
| tracing.otlp.grpc.tls.cert | string | `""` | The path to the public certificate. When using this option, setting the key option is required. |
| tracing.otlp.grpc.tls.insecureSkipVerify | bool | `false` | When set to true, the TLS connection accepts any certificate presented by the server regardless of the hostnames it covers. |
| tracing.otlp.grpc.tls.key | string | `""` | The path to the private key. When using this option, setting the cert option is required. |
| tracing.otlp.http.enabled | bool | `false` | Set to true in order to send metrics to the OpenTelemetry Collector using HTTP. |
| tracing.otlp.http.endpoint | string | `""` | Format: <scheme>://<host>:<port><path>. Default: http://localhost:4318/v1/metrics |
| tracing.otlp.http.headers | object | `{}` | Additional headers sent with metrics by the reporter to the OpenTelemetry Collector. |
| tracing.otlp.http.tls.ca | string | `""` | The path to the certificate authority, it defaults to the system bundle. |
| tracing.otlp.http.tls.cert | string | `""` | The path to the public certificate. When using this option, setting the key option is required. |
| tracing.otlp.http.tls.insecureSkipVerify | bool | `false` | When set to true, the TLS connection accepts any certificate presented by the server regardless of the hostnames it covers. |
| tracing.otlp.http.tls.key | string | `""` | The path to the private key. When using this option, setting the cert option is required. |
| updateStrategy.rollingUpdate.maxSurge | int | `1` |  |
| updateStrategy.rollingUpdate.maxUnavailable | int | `0` |  |
| updateStrategy.type | string | `"RollingUpdate"` | Customize updateStrategy of Deployment or DaemonSet |
| volumes | list | `[]` | Add volumes to the traefik pod. The volume name will be passed to tpl. This can be used to mount a cert pair or a configmap that holds a config.toml file. After the volume has been mounted, add the configs into traefik by using the `additionalArguments` list below, eg: `additionalArguments: - "--providers.file.filename=/config/dynamic.toml" - "--ping" - "--ping.entrypoint=web"` |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)