{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "nfs-subdir-external-provisioner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "nfs-subdir-external-provisioner.fullname" -}}
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
Create chart name and version as used by the chart label.
*/}}
{{- define "nfs-subdir-external-provisioner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "nfs-subdir-external-provisioner.provisionerName" -}}
{{- if .Values.storageClass.provisionerName -}}
kubernetes.external/{{ .Values.storageClass.provisionerName }}
{{- else -}}
cluster.local/{{ template "nfs-subdir-external-provisioner.fullname" . -}}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "nfs-subdir-external-provisioner.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "nfs-subdir-external-provisioner.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiVersion for podSecurityPolicy.
*/}}
{{- define "podSecurityPolicy.apiVersion" -}}
{{- if semverCompare ">=1.10-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "policy/v1beta1" -}}
{{- else -}}
{{- print "extensions/v1beta1" -}}
{{- end -}}
{{- end -}}

{{/*
Return the appropriate apiGroup for podSecurityPolicy.
*/}}
{{- define "podSecurityPolicy.apiGroup" -}}
{{- if semverCompare ">=1.10-0" .Capabilities.KubeVersion.GitVersion -}}
{{- print "policy" -}}
{{- else -}}
{{- print "extensions" -}}
{{- end -}}
{{- end -}}
