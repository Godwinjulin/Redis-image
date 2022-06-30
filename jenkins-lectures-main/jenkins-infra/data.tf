data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical
}

data "cloudinit_config" "userdata" {
  gzip          = true
  base64_encode = true

  # Main cloud-config configuration file.
  part {
    content_type = "text/x-shellscript"
    filename     = "userdata_jenkins"
    content      = templatefile("./templates/userdata_jenkins.tpl", {})
  }
}