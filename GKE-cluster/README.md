# GKE clusters (Terraform)

```
modules/network   custom VPC, subnet + pod/service ranges, optional Cloud NAT
modules/gke       cluster, dedicated node service account, node pools
envs/dev          zonal, public nodes, no deletion protection (cheap)
envs/stage        zonal, private nodes, deletion protected
envs/perf         regional, private nodes, prod-shaped for load tests
envs/prod         regional, private nodes, STABLE channel, deletion protected
```

All environments run in Mumbai (`asia-south1`). Each `envs/<env>` has the same `main.tf`,
`variables.tf` and `outputs.tf`; only `terraform.tfvars` differs. Resource names are prefixed
with the environment (e.g. `dev-gke-cluster`) and each environment has non-overlapping IP ranges.

| env   | location        | nodes                         | private | del. protection |
|-------|-----------------|-------------------------------|---------|-----------------|
| dev   | asia-south1-a   | 2 x e2-medium                 | no      | no              |
| stage | asia-south1-a   | 2 x e2-standard-2             | yes     | yes             |
| perf  | asia-south1     | 1 per zone (3) x e2-standard-4| yes     | no              |
| prod  | asia-south1     | 2 per zone (6) x e2-standard-4| yes     | yes             |

On a regional cluster `node_count` is per zone.

## Deploy one environment

```
gcloud auth application-default login
cd envs/dev          # or stage / perf / prod
terraform init
terraform plan
terraform apply
```

## Before stage/perf/prod

- Set `authorized_networks` in `terraform.tfvars` (currently empty = API open to the internet).
- Enable the GCS backend block in `main.tf` (state per environment under `gke/<env>`).
- Prefer a separate GCP project per environment (`project_id`), at least for prod.

## Destroy (stops billing)

```
terraform destroy
```
