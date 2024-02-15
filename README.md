# Deployment and Observability on Kind Cluster

## Table of Contents
- [Overview](#overview)
- [Installation](#installation)
- [Reference](#reference)

### Overview

This project project can be considred as a simple template for deploying simple application and some observability tools on **Kind Cluster** using Terrafom

### Installation

During all provided in the follwing steps, we assume your areon an Ubuntu server, otherwise the kind cluster installation and configuration won't work.

Before configuring the project, ensure the following tools are installed:
- [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)

#### Installation Steps : 

#### Step 0: Clone the repository locally

#### Step 1: Install and configure your kind cluster
> Dependent tools will during this process such as **Docker Engine, Kubernetes Controller (kubectl)**
to process run the following command:
- `chmod u+x kube-kind-cluster.sh` to set the file as an executable by the user
- `./kube-kind-cluster.sh` to start the script

#### Step 2: load resources on the cluster
> this step will be done with terraform, sot to step into the terraform folder to perform the next command. **Note:** we assume Terrafrm is already installed
- `terraform init` this initialise the local backend and get neede provider ressource
- `terraform plan` this valide you configuration and provide and overview of your cluster after apply
- `terraform apply` to apply the configuration state on your cluster

After completion of the command, run the following command to check the ressource deployed 
- `kubectl get all -n observability`
- `kubectl get all -n ns-ignitedev-test`

To access the ressource you can forward each port independtly with the following command
- `kubectl port-forward -n <namespace-name> svc/<service-name> <host-por>:<service-port> --address=0.0.0.0 `

#### Reference
- [Terraform Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [Kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/blob/main/charts/kube-prometheus-stack/README.md) 
- [Hashicorp kubernetes provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)
- [Hashicorp helm provider](https://registry.terraform.io/providers/hashicorp/helm/latest/docs)