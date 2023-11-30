terraform {
  required_providers {
    vultr = {
      source  = "vultr/vultr"
      version = "~> 2.3"  
    }
  }
}

provider "vultr" {
  api_key = "SILLVA2A6J3F6S4SKKSNXAPFNZFMWNFF2MRA"
}

resource "vultr_instance" "wordpress_vm" {
  label      = "wordpress-vm"
  region     = "fra"              
  plan       = "vc2-2c-4gb"  # Adjust based on your requirements
  os_id      = "387"  # OS ID for a Linux distribution of your choice

  user_data = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io docker-compose  # Install Docker and Docker Compose
    systemctl start docker
    systemctl enable docker

    git clone -b hello_vultr https://github.com/noor-rasooli/Terraform-day2.git /root/Terraform/Test
    docker build -t your-docker-image /root/Terraform/Test
    docker run -d -p 80:80 your-docker-image
  EOF
}

