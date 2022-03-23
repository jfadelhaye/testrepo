curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update -y && sudo apt-get install -y nomad
systemctl start nomad

cat <<EOF >> /etc/nomad.d/nomad.hcl
acl {
  enabled = true
}

EOF
systemctl restart nomad
echo " gives 5 secondes to restart nomad... "
sleep 5 
nomad acl bootstrap | tee /home/ubuntu/my_acl_token

