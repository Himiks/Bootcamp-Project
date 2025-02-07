resource "helm_release" "atlantis" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"

  set {
    name  = "repo"
    value = "Bootcamp-Project"
  }



  set {
  name  = "token"
  value = ""
}
}

