# resource "helm_release" "jenkins" {
#   name             = "jenkins"
#   repository       = "https://charts.jenkins.io"
#   chart            = "jenkins"
#   create_namespace = true
#   namespace        = "jenkins"
#   atomic           = true
#   lint             = true
#   values = [
#     "${file("values.yaml")}"
#   ]
# }

# resource "helm_release" "cm" {
#   name             = "cm"
#   repository       = "https://charts.jetstack.io"
#   chart            = "cert-manager"
#   namespace        = "cert-manager"
#   version          = "v1.5.3"
#   lint             = true
#   create_namespace = true
# }