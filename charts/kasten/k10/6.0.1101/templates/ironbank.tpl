{{/*
This file is used to fail the helm deployment if certain values are set which are
not compatible with an Ironbank deployment.
*/}}
{{- include "k10.fail.ironbankRHMarketplace" . -}}
{{- include "k10.fail.ironbankGrafana" . -}}
{{- include "k10.fail.ironbankPrometheus" . -}}
