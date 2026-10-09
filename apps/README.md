# Demo apps (dev)

Three identical hello-world HTTP apps (Python, no dependencies) deployed to the `dev` GKE cluster.

```
apps/app1  app.py, Dockerfile, k8s/deployment.yaml (Deployment x2 replicas + LoadBalancer Service)
apps/app2
apps/app3
apps/namespace.yaml                   namespace "dev"
.github/workflows/_deploy-app.yml     reusable: build -> push to Artifact Registry -> kubectl apply
.github/workflows/app{1,2,3}.yml      triggers (push to main touching that app, or manual)
```

Each app answers `GET /` with `Hello World from <app> (version <sha>)` and `GET /healthz` with `ok`.

## Run locally

```
docker build -t app1 apps/app1
docker run --rm -p 8080:8080 app1
```

## One-time GCP setup (not done yet)

1. Dev cluster running: `envs/dev` in `GKE-cluster` (`dev-gke-cluster`, `asia-south1-a`).
2. Artifact Registry Docker repo `apps` in `asia-south1`.
3. A deployer service account with `roles/artifactregistry.writer` and `roles/container.developer`.
4. Workload Identity Federation pool/provider trusting this GitHub repo, with the service account
   allowed to be impersonated by it.
5. GitHub repo secrets: `GCP_WIF_PROVIDER` (full provider resource name) and `GCP_SERVICE_ACCOUNT`.

Then push to `main` (or run a workflow manually) to deploy. Find the external IP with
`kubectl -n dev get svc`.

The Services are `LoadBalancer` for the demo; each one creates a billable Google load balancer.
