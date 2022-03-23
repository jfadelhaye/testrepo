curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update -y && apt-get install -y nomad
systemctl start nomad

echo "enabling ACL ..."

cat <<EOF >> /etc/nomad.d/nomad.hcl
acl {
  enabled = true
}

EOF
systemctl restart nomad
echo " gives 5 secondes to restart nomad... "
sleep 5 
nomad acl bootstrap | tee /tmp/my_acl_token
echo "you can also find your acl token in /tmp/my_acl_token"

