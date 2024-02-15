provider "kubernetes" {
  config_path    = "../config/kubeconfig"
}

provider "helm" {
  kubernetes {
    config_path = "../config/kubeconfig"
  }
}