# Simple express Application deployment

resource "kubernetes_namespace_v1" "express-hw" {
  metadata {
    annotations = {
      name = var.namespace
    }

    labels = {
      env = "test"
    }

    name = var.namespace
  }
}

resource "kubernetes_deployment_v1" "express-hw" {
  metadata {
    name = "express-hw"
    labels = {
      env = "test"
    }
    namespace = var.namespace
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "express-hw"
      }
    }

    template {
      metadata {
        labels = {
          app = "express-hw"
          env = "test"
        }
      }

      spec {
        container {
          image = "stephanezang/express-hw:latest"
          name  = "express-hw"
          image_pull_policy = "Always"

          resources {
            requests = {
              memory = "250Mi"
            }
          }
          env {
            name = "HTTP_LISTEN_PORT"
            value = 8008
          }

          liveness_probe {
            tcp_socket {
              port = 8008
            }

            initial_delay_seconds = 20
            period_seconds        = 15
            timeout_seconds = 2
          }

          readiness_probe {
            tcp_socket {
              port = 8008
            }

            initial_delay_seconds = 20
            period_seconds        = 15
            timeout_seconds = 10
          }
        }
      }
    }
  }
}

# Observability Ressources

resource "kubernetes_service" "express-hw" {
  metadata {
    name = "express-hw-service"
    namespace = var.namespace
  }
  spec {
    selector = {
      app = "express-hw"
    }
    port {
      port        = 8008
      target_port = 8008
    }

    type = "ClusterIP"
  }
}


resource "kubernetes_namespace_v1" "observability" {
  metadata {
    annotations = {
      name = "observability"
    }

    labels = {
      env = "test"
    }

    name = "observability"
  }
}

resource "helm_release" "prometheus" {
  name       = "prometheus-stack"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace = "observability"

  values = [
    "${file("../kubernetes/values.yml")}"
  ]

}