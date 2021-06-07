  provisioner "remote-exec" {
    command = "C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule",
    interpreter = ["PowerShell"]
    connection {
      type     = "winrm"
      user     = "Administrator"
      password = "${var.admin_password}"
    }
  }

# Example of using a userdata file in Terraform
# <powershell>
#  C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule
# </powershell>

resource "aws_instance" "my-test-instance" {
  ami             = "${data.aws_ami.ec2-worker-initial-encrypted-ami.id}"
  instance_type   = "t2.micro"

  tags {
    Name = "my-test-instance"
  }

  user_data = "${file(userdata.txt)}"
}



provisioner "remote-exec" {
    connection {
      type     = "winrm"
      user     = "Administrator"
      password = "${var.admin_password}"
    }

inline = [
         "powershell -ExecutionPolicy Unrestricted -File C:\\ProgramData\\Amazon\\EC2-Windows\\Launch\\Scripts\\InitializeInstance.ps1 -Schedule"
        ]
      }

  provisioner "file" {
    source      = "${path.module}/some_path"
    destination = "C:/some_path"

    connection {
      host = "${azurerm_network_interface.vm_nic.private_ip_address}"
      timeout  = "3m"
      type     = "winrm"
      https    = true
      port     = 5986
      use_ntlm = true
      insecure = true

      #cacert = "${azurerm_key_vault_certificate.vm_cert.certificate_data}"
      user     = var.admin_username
      password = var.admin_password
    }
  }