# resource "aws_key_pair" "launch_tamplate" {
#   key_name   = "deployer-key"
#   public_key = file("${path.module}/rsa.pub")
# }


resource "aws_key_pair" "launch_tamplate" {
  key_name   = "my-keypair"  # Change this to your desired key pair name
  public_key = tls_private_key.my_keypair.public_key_openssh
}

resource "tls_private_key" "my_keypair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}