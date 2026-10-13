# Demo apps (dev) - deployed with Helm

Three identical hello-world HTTP apps (Python, no dependencies) deployed to the `dev` GKE cluster
using one shared Helm chart.

```
charts/hello-app/                       the chart (Deployment + Service), values.yaml = shared defaults
apps/app1, app2, app3
    app.py, Dockerfile                  the app
    values-dev.yaml                     per-app, per-environment overrides (appName, image repository)
.github/workflows/_deploy-app.yml       reusable: build -> push -> helm lint -> helm upgrade --install
.github/workflows/app{1,2,3}.yml        triggers (push to main touching that app or the chart, or manual)
```

Each app answers `GET /` with `Hello World from <app> (version <sha>)` and `GET /healthz` with `ok`.
The pipeline sets `image.repository` and `image.tag` (git short SHA) on every deploy; each app is its
own Helm release (`app1`, `app2`, `app3`) in the `dev` namespace (created by `--create-namespace`).

## Add an environment (e.g. stage)

Add `apps/<app>/values-stage.yaml` and point the workflow's `NAMESPACE`/cluster/values file at it.
Typical overrides: `replicaCount`, `resources`, `service.type: ClusterIP` (behind an Ingress).

## Try the chart locally (needs Helm; touches nothing in the cloud)

```
helm lint charts/hello-app -f apps/app1/values-dev.yaml --set image.tag=test
helm template app1 charts/hello-app -f apps/app1/values-dev.yaml --set image.tag=test
```

## One-time GCP setup (not done yet)

1. Dev cluster running: `GKE-cluster/envs/dev` (`dev-gke-cluster`, `asia-south1-a`).
2. CI/CD plumbing: `GKE-cluster/envs/cicd` (Artifact Registry repo `apps`, deployer service account,
   Workload Identity Federation).
3. GitHub repo secrets `GCP_WIF_PROVIDER` and `GCP_SERVICE_ACCOUNT` from `terraform output` in `envs/cicd`.

Then push to `main` (or run a workflow manually) to deploy.

The Services are `LoadBalancer` for the demo; each creates a billable Google load balancer.
