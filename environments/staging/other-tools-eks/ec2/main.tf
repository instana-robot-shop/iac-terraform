/**
  Overview:
   * create ec2 instance dedicated to each devops tools (e.g. jenkins, sonarqube, etc.)
*/

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = {
    // cicd 
    jenkins = "jenkins.sh", 
    sonarqube = "sonarqube.sh",

    // communication
    slack = "slack.sh",

    // secrets management 
    hc-vault = "hc-vault.sh",

    // monitoring 
    prometheus = "prometheus.sh",
    grafana = "grafana.sh",
    jaeger = "jaeger.sh",
    kuma = "kuma.sh",
    sentry = "sentry.sh",

    // logs 
    loki = "loki.sh",
  }

  name = "instance-${each.key}"

  ami                    = "ami-ebd02392"
  instance_type          = "t2.micro"
  monitoring             = true
#   vpc_security_group_ids = ["sg-12345678"]
#   subnet_id              = "subnet-eddcdzz4"
  user_data              = filebase64("${each.value}")
  
  tags = {
    Terraform   = "true"
    Environment = "global"
  }
}