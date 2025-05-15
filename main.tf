# main.tf - Somente recursos dentro do cluster EKS (sem provisionar o cluster com Terraform)

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}
#
# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "19.21.0"
#
#   cluster_name    = var.cluster_name
#   cluster_version = var.cluster_version
#   vpc_id          = var.vpc_id
#   subnet_ids      = var.subnet_ids
#
#   eks_managed_node_groups = {
#     fastfood-node = {
#       desired_size = 1
#       max_size     = 2
#       min_size     = 1
#
#       instance_types = [var.instance_type]
#       key_name       = var.key_name
#     }
#   }
# }

resource "kubernetes_config_map" "fastfood_config" {
  metadata {
    name = "fastfood-config"
  }

  data = {
    DATABASE      = "postgres"
    DATABASE_PORT = "5432"
    DATABASE_HOST = "postgres-service"
  }
}

resource "kubernetes_secret" "fastfood_secret" {
  metadata {
    name = "fastfood-secret"
  }

  data = {
    DATABASE_USER     = base64encode("fastfood")
    DATABASE_PASSWORD = base64encode("Teste123")
  }
}

resource "kubernetes_deployment" "fastfood_app" {
  metadata {
    name = "fastfood-app"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "fastfood-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "fastfood-app"
        }
      }

      spec {
        container {
          name              = "fastfood"
          image             = var.image_url
          image_pull_policy = "Always"

          port {
            container_port = 8080
          }

          env {
            name = "DATABASE_HOST"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.fastfood_config.metadata[0].name
                key  = "DATABASE_HOST"
              }
            }
          }

          env {
            name = "DATABASE"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.fastfood_config.metadata[0].name
                key  = "DATABASE"
              }
            }
          }

          env {
            name = "DATABASE_PORT"
            value_from {
              config_map_key_ref {
                name = kubernetes_config_map.fastfood_config.metadata[0].name
                key  = "DATABASE_PORT"
              }
            }
          }

          env {
            name = "DATABASE_USER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.fastfood_secret.metadata[0].name
                key  = "DATABASE_USER"
              }
            }
          }

          env {
            name = "DATABASE_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.fastfood_secret.metadata[0].name
                key  = "DATABASE_PASSWORD"
              }
            }
          }

          resources {
            limits = {
              cpu    = "500m"
              memory = "1Gi"
            }
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "fastfood_service" {
  metadata {
    name = "fastfood-service"
  }

  spec {
    selector = {
      app = "fastfood-app"
    }

    port {
      name        = "http"
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "fastfood_ingress" {
  metadata {
    name = "fastfood-ingress"
    annotations = {
      "nginx.ingress.kubernetes.io/use-forwarded-headers" = "true"
      "nginx.ingress.kubernetes.io/rewrite-target"        = "/"
    }
  }

  spec {
    rule {
      host = var.ingress_host

      http {
        path {
          path      = "/"
          path_type = "Prefix"

          backend {
            service {
              name = kubernetes_service.fastfood_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}