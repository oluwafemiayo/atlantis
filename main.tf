# Helm Release for Atlantis
resource "helm_release" "atlantis" {
  name      = "atlantis"
  namespace = "atlantis"

  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  version    = "5.5.1"
 
  values = [
    <<YAML
    image:
      repository: ghcr.io/runatlantis/atlantis

    github:
      user: "${var.github_user}"
      token: "${var.github_token}"
      secret: "${var.github_secret}"
     

    orgAllowlist: "github.com/oluwafemiayo/monitoring"
    atlantisUrl: "${var.atlantis_repo_url}"
    YAML
  ]
}
