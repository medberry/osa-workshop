#
# spin up some Cirros instances on the cloud
#
resource "null_resource" "cirros-instances" {

# right now this just copies over the file - later it'll run it and then it'll need this dependency
#  depends_on = ["null_resource.osa-playbooks"]

  # count of zero will prevent this from running
  count         = "1"

  connection {
    type        = "ssh"
    user        = "root"
    host        = "${packet_device.control.0.access_public_ipv4}"
    private_key = "${tls_private_key.default.private_key_pem}"
    agent       = false
    timeout     = "30s"
  }

  provisioner "file" {
    source      = "Cirros.sh"
    destination = "Cirros.sh"
  }

  # TODO 
  # find the lxc utility container
  # push file into container
  # run the file
#  provisioner "remote-exec" {
#    inline = [
#       "lxc file push Cirros.sh utility-container-name/"
#       "lxc-attach -n utility-container-name -- bash Cirros.sh"
#    ]
#  }
}
