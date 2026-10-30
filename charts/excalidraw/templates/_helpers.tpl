{{/*
Expand the name of the chart.
*/}}
{{- define "excalidraw.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "excalidraw.fullname" -}}
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

{{- define "excalidraw.selectorLabels" -}}
app.kubernetes.io/name: {{ include "excalidraw.name" .ctx }}
app.kubernetes.io/instance: {{ .ctx.Release.Name }}
app.kubernetes.io/component: {{ .component }}
{{- end -}}

{{- define "excalidraw.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .ctx.Chart.Name .ctx.Chart.Version | replace "+" "_" }}
{{ include "excalidraw.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .ctx.Release.Service }}
{{- end -}}

{{/* usage: include "excalidraw.image" (dict "ctx" . "img" .Values.web.image) */}}
{{- define "excalidraw.image" -}}
{{- $reg := default .img.registry .ctx.Values.global.imageRegistry -}}
{{- $repo := .img.repository -}}
{{- if $reg -}}{{- $repo = printf "%s/%s" $reg .img.repository -}}{{- end -}}
{{- if .img.digest -}}
{{- printf "%s@%s" $repo .img.digest -}}
{{- else -}}
{{- printf "%s:%s" $repo (default "latest" .img.tag) -}}
{{- end -}}
{{- end -}}

{{/* URL the browser must use to reach excalidraw-room */}}
{{- define "excalidraw.wsUrl" -}}
{{- if .Values.collab.wsServerUrl -}}
{{- .Values.collab.wsServerUrl | trimSuffix "/" -}}
{{- else if .Values.ingress.room.host -}}
{{- printf "%s://%s" .Values.ingress.scheme .Values.ingress.room.host -}}
{{- else -}}
{{- printf "%s://%s" .Values.ingress.scheme .Values.ingress.web.host -}}
{{- end -}}
{{- end -}}
