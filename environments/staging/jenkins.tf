/*
  NOTE:
    - jenkins requires atleast a large instance type (e.g. t3.medium??) to run  

*/

# resource "helm_release" "jenkins" {
#   name       = "jenkins"
#   repository = "https://charts.jenkins.io"
#   chart      = "jenkins"

#   namespace  = "cicd" 

#   values = [
#     "${file("jenkins-values.yaml")}"
#   ]

#   set_sensitive {
#     name  = "controller.adminUser"
#     value = var.jenkins_admin_user
#   }

#   set_sensitive {
#     name  = "controller.adminPassword"
#     value = var.jenkins_admin_password
#   }
# }