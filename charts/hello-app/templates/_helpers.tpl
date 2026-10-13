{{/* Resource name: the app name (app1, app2, app3). */}}
{{- define "hello-app.name" -}}
{{- required "appName is required (set it in apps/<app>/values-<env>.yaml)" .Values.appName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "hello-app.labels" -}}
app: {{ include "hello-app.name" . }}
app.kubernetes.io/name: {{ include "hello-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end -}}

{{- define "hello-app.selectorLabels" -}}
app: {{ include "hello-app.name" . }}
{{- end -}}

{{- define "hello-app.image" -}}
{{- $repo := required "image.repository is required" .Values.image.repository -}}
{{- $tag := required "image.tag is required" .Values.image.tag -}}
{{- printf "%s:%s" $repo $tag -}}
{{- end -}}
