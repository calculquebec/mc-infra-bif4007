terraform {
  required_version = ">= 0.14.2"
}

variable "password" {}
variable "email" {}

module "openstack" {
  source         = "git::https://github.com/ComputeCanada/magic_castle.git//openstack?ref=11.9.5"
  config_git_url = "https://github.com/ComputeCanada/puppet-magic_castle.git"
  config_version = "11.9.5"

  cluster_name = "bif4007"
  domain       = "calculquebec.cloud"
  image        = "Rocky-8.6-x64-2022-07"

  instances = {
    mgmt   = { type = "p4-6gb", tags = ["puppet", "mgmt", "nfs"], count = 1 }
    login  = { type = "p4-6gb", tags = ["login", "public", "proxy"], count = 1 }
    node   = { type = "c8-90gb-186", tags = ["node"], count = 1 }
  }

  volumes = {
    nfs = {
      home     = { size = 50 }
      project  = { size = 100 }
      scratch  = { size = 800 }
    }
  }

  generate_ssh_key = true
  public_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCy6vaeMkT+8lNOpvG+scN1iiRby35dGLyh1s3NOzufzqjAVvZL6t/vd7CN/hbTg+UUCc3V1hJOxGFGD3lrbXho1R5S4pZZ+Hge3icJm4BAPX6O9+H7aMWh/DE/vxHhyyC5QX8vg3AqUtCjihT03xftCC1XGzcP5lvs/bWgn1RS3pXY85UGY80NsRiGK08HpRER7ifNbo9zipIO4eQpRvTq6Ent5mqmeULMRX99SAbgUciaz5mUcULw5OimNFSjakdDRyF2xrdVsX6mwHPUT3UIXAxxS5GGTWIIH+jG0L0rqnjtnRwj8Imw+zOtE5itMg4kCNO+q5KJBH1jU6g57JFiEoxviHQH1ATlsw8e6gI2nhkfi10NgIzQ/yLxsK3IS4XwqMqDRInf6eGrf1CvbxYjOvpm7pOvLbvBdSrH+Ynx5X743oNIAmwjSoJ+ABa1RQp0XNrDfQXYmRrCA3sKgh/bOge+B8HDVEkCdSv+bAp/4rfGOKy4eOPsuzvrxnS8OWNet0+bAUV1Ta0VigHlFgEvQtS4/jrOO3It0ZaYMIZFAWqsjXimJ5LiT1TAgOCUO9950ZUA8BWQuSO+/EzREPCThRvFPKy82HAPOY8fo3jrEekuJdrjF8IDHxYL51YR+WPupY52HCHZkg4iDxKXnkrLS3K5/AIa5/+/CnHWL5WGHw==",
    "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtK+7I+alsG4rJvg96ycHCl9Cjugww4D+UnPXCm1qi+kwq/SHyc3dXdPt1ls47jerAj3jfWx39zFovN3eyRsxG0PyMLyl2xpeYxT9BKWVqClijYKfUBj74fFsOj9ma7rw6Y7ksNXA4zL1VVhRH7vIhgjWZZO1VH1f6GYrB6sVBsjodKYQLAF+TLPJsONYOOQe8iKxdOCob/9D5nWRgIARTNGWc4m2EQAciDoZ2Qmoy0BSFs7amhMqytmFk80Ww83K2Fa4lqn/27rMb4NZlbzYKWfmnPXefzW/oa85WmFM+al95Lwg55kXWWTgOCBj1atYizLCQwZ1KSVPcn6fQVB3Yw== felix",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQ6jCA+PeFQ3Mimz4sM7I198PYBODyBy6Pe23yz+gCbFVbZs9xwzZ/8UUC3uDJeQCOMmBcxqkH2J9EZJy+3dMPr6J8/94iizde7ouzmHP63SJ1NSg98VcqQwIQGpb16rIjV5CSWv87mkcuKC4JGA0ILeaHsKGFd7IOK/wOrywzOeIAValJsyLx/eWkOtQ/pEYHjxzePKQh1s2/OwXLUFZVLsEwu+fh//jRpuh+egKCGF85g6smVLg47ArOpTkDLSAyXO3kP+ZQxNFzA+mOu1fjK9DcQ2+hKe3tJyN3ZqGTpkbJWv8PY3W+mPNudYAMgwZVtJaq4i5QkDs8Qk06+HNb4tFt4r3ECb2Gt0QW9CebDdE4ndAHHxZ9P2TZNBLpAUb9PKQye1A7D3vuUhqAW43zeV9z+1I07QKe3oV0qDZvt2wC+pvtFF4z2Xr02CAW6sUycPFAtdHZO8ZPBPmgKE7x8fofIBBAZRtt1DANmqU0xUGk+FAneuz86SXr/y++ugDPvhZWC7+49fe0c8S8C5N78Nn4/hYMR+e0IDHF/CLkcafbnSeJGHJd2nh4VaTXc9vtJzd9EFiioyHoFMUkozgk3G2FKLpLu5JTTylW4webpsnpeHieRzewCaGIPQhaYRjv4EWAjgB0bWqaT2aW8fKeMy+JLBH+FB5x7BSa15WA/Q== charles@alfheim",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDa2nbgmU9ptZP1+8gq+1dajCYxuZQP04QptwiHj0xP8ERTdRnUGmENFqm/kNkntj4fvCbAGlEk96g1HQQAruAzKTIndqu0A6B8Dgip+US5zL+Zl8SFN/IR02xjT1B9hkgV0TY6wU5QUAXQdGD4kh9XN4dDHBI1F3UJokxuUi4bR8DO80x6lCJiB8i+jNKijKGf8Z6Lmob9Crr+ZoTKWi7Oc8bafJP3FEJPCtTijiDzFfOtqQGbJihGI7CffNKeB0HBByt63IiSACOE584RhuzHyPKKze2izdSUubS3rQShj0F7P7uQHYvmeZh0NP6FMYKNUTdbROmCGc1D0gMXIzmD mboisson@dhcp-106-215.gel.ulaval.ca",
  ]

  nb_users = 20
  # Shared password, randomly chosen if blank
  guest_passwd = var.password

  hieradata = file("config.yaml")
}

output "accounts" {
  value = module.openstack.accounts
}

output "public_ip" {
  value = module.openstack.public_ip
}

## Uncomment to register your domain name with CloudFlare
module "dns" {
  source           = "git::https://github.com/ComputeCanada/magic_castle.git//dns/cloudflare?ref=11.9.5"
  email            = var.email
  name             = module.openstack.cluster_name
  domain           = module.openstack.domain
  public_instances = module.openstack.public_instances
  ssh_private_key  = module.openstack.ssh_private_key
  sudoer_username  = module.openstack.accounts.sudoer.username
}
