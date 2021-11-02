resource "alicloud_vpc" "vpc" {
  name       = "tf_test_foo"
  cidr_block = "172.16.0.0/12"
}

resource "alicloud_vswitch" "vsw" {
  vpc_id            = alicloud_vpc.vpc.id
  cidr_block        = "172.16.0.0/21"
  availability_zone = "cn-beijing-b"
}

resource "alicloud_vpn_gateway" "foo" {
  name                 = "vpnGatewayConfig"
  vpc_id               = alicloud_vpc.vpc.id
  bandwidth            = "10"
  enable_ssl           = true
  instance_charge_type = "PostPaid"
  description          = "test_create_description"
  vswitch_id           = alicloud_vswitch.vsw.id
}