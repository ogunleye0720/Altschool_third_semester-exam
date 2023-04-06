resource "helm_release" "prometheus" {
  depends_on = [kubernetes_namespace.monitoring, time_sleep.wait_for_kubernetes]
  chart      = "kube-prometheus-stack"
  name       = "prometheus"
  namespace  = kubernetes_namespace.monitoring.id
  create_namespace = true
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "45.7.1"
  values = [
    file("prom-values.yaml")
  ]
  timeout = 2000 

  set {
    name  = "podSecurityPolicy.enabled"
    value = true
  }

  set {
    name  = "server.persistentVolume.enabled"
    value = false
  }

  # You can provide a map of value using yamlencode. Don't forget to escape the last element after point in the name
  set {
    name = "server\\.resources"
    value = yamlencode({
      limits = {
        cpu    = "200m"
        memory = "50Mi"
      }
      requests = {
        cpu    = "100m"
        memory = "30Mi"
      }
    })
  }
}