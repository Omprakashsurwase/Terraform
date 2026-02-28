aws_region = "us-east-1"
instance_name = "my-server"
instance_type = "t2.micro"
root_volume_size = 20
environment = "dev"
ssh_allowed_cidr = "0.0.0.0/0"
public_key_path = "~/.ssh/id_rsa.pub"
      "type": "aws_ami",
      "name": "amazon_linux",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "architecture": "x86_64",
            "arn": "arn:aws:ec2:us-east-1::image/ami-0199fa5fada510433",
            "block_device_mappings": [
              {
                "device_name": "/dev/xvda",
                "ebs": {
                  "delete_on_termination": "true",
                  "encrypted": "false",
                  "iops": "0",
                  "snapshot_id": "snap-05dc16d8999bc5119",
                  "throughput": "0",
                  "volume_initialization_rate": "0",
                  "volume_size": "8",
                  "volume_type": "gp2"
                },
                "no_device": "",
                "virtual_name": ""
              }
            ],
            "boot_mode": "",
            "creation_date": "2026-02-13T22:49:15.000Z",
            "deprecation_time": "2026-05-15T01:06:00.000Z",
            "description": "Amazon Linux 2 AMI 2.0.20260216.0 x86_64 HVM gp2",
            "ena_support": true,
            "executable_users": null,
            "filter": [
              {
                "name": "name",
                "values": [
                  "amzn2-ami-hvm-*-x86_64-gp2"
                ]
              },
              {
                "name": "state",
                "values": [
                  "available"
                ]
              }
            ],
            "hypervisor": "xen",
            "id": "ami-0199fa5fada510433",
            "image_id": "ami-0199fa5fada510433",
            "image_location": "amazon/amzn2-ami-hvm-2.0.20260216.0-x86_64-gp2",
            "image_owner_alias": "amazon",
            "image_type": "machine",
            "imds_support": "",
            "include_deprecated": false,
            "kernel_id": "",
            "last_launched_time": "",
            "most_recent": true,
            "name": "amzn2-ami-hvm-2.0.20260216.0-x86_64-gp2",
            "name_regex": null,
            "owner_id": "137112412989",
            "owners": [
              "amazon"
            ],
            "platform": "",
            "platform_details": "Linux/UNIX",
            "product_codes": [],
            "public": true,
            "ramdisk_id": "",
            "root_device_name": "/dev/xvda",
            "root_device_type": "ebs",
            "root_snapshot_id": "snap-05dc16d8999bc5119",
            "sriov_net_support": "simple",
            "state": "available",
            "state_reason": {
              "code": "UNSET",
              "message": "UNSET"
            },
            "tags": {},
            "timeouts": null,
            "tpm_support": "",
            "uefi_data": null,
            "usage_operation": "RunInstances",
            "virtualization_type": "hvm"
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "main",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "ami": "ami-0199fa5fada510433",
            "arn": "arn:aws:ec2:us-east-1:548586340481:instance/i-050a3791d3c27b75d",
            "associate_public_ip_address": true,
            "availability_zone": "us-east-1c",
            "capacity_reservation_specification": [
              {
                "capacity_reservation_preference": "open",
                "capacity_reservation_target": []
              }
            ],
            "cpu_core_count": 1,
            "cpu_options": [
              {
                "amd_sev_snp": "",
                "core_count": 1,
                "threads_per_core": 1
              }
            ],
            "cpu_threads_per_core": 1,
            "credit_specification": [
              {
                "cpu_credits": "standard"
              }
            ],
            "disable_api_stop": false,
            "disable_api_termination": false,
            "ebs_block_device": [],
            "ebs_optimized": false,
            "enable_primary_ipv6": null,
            "enclave_options": [
              {
                "enabled": false
              }
            ],
            "ephemeral_block_device": [],
            "get_password_data": false,
            "hibernation": false,
            "host_id": "",
            "host_resource_group_arn": null,
            "iam_instance_profile": "",
            "id": "i-050a3791d3c27b75d",
            "instance_initiated_shutdown_behavior": "stop",
            "instance_lifecycle": "",
            "instance_market_options": [],
            "instance_state": "running",
            "instance_type": "t2.micro",
            "ipv6_address_count": 0,
            "ipv6_addresses": [],
            "key_name": "my-server-key",
            "launch_template": [],
            "maintenance_options": [
              {
                "auto_recovery": "default"
              }
            ],
            "metadata_options": [
              {
                "http_endpoint": "enabled",
                "http_protocol_ipv6": "disabled",
                "http_put_response_hop_limit": 1,
                "http_tokens": "optional",
                "instance_metadata_tags": "disabled"
              }
            ],
            "monitoring": true,
            "network_interface": [],
            "outpost_arn": "",
            "password_data": "",
            "placement_group": "",
            "placement_partition_number": 0,
            "primary_network_interface_id": "eni-07f821880bb4943ac",
            "private_dns": "ip-172-31-16-221.ec2.internal",
            "private_dns_name_options": [
              {
                "enable_resource_name_dns_a_record": false,
                "enable_resource_name_dns_aaaa_record": false,
                "hostname_type": "ip-name"
              }
            ],
            "private_ip": "172.31.16.221",
            "public_dns": "ec2-54-90-122-183.compute-1.amazonaws.com",
            "public_ip": "54.90.122.183",
            "root_block_device": [
              {
                "delete_on_termination": true,
                "device_name": "/dev/xvda",
                "encrypted": true,
                "iops": 3000,
                "kms_key_id": "arn:aws:kms:us-east-1:548586340481:key/0444d65a-95e8-4788-8d8b-7227910b5581",
                "tags": null,
                "tags_all": {},
                "throughput": 125,
                "volume_id": "vol-0d359da9fa74a9d7d",
                "volume_size": 20,
                "volume_type": "gp3"
              }
            ],
            "secondary_private_ips": [],
            "security_groups": [
              "my-server-sg"
            ],
            "source_dest_check": true,
            "spot_instance_request_id": "",
            "subnet_id": "subnet-04f57935b967795d8",
            "tags": {
              "Environment": "dev",
              "ManagedBy": "Terraform",
              "Name": "my-server"
            },
            "tags_all": {
              "Environment": "dev",
              "ManagedBy": "Terraform",
              "Name": "my-server"
            },
            "tenancy": "default",
            "timeouts": null,
            "user_data": "a0d6d5c1359073e0ec3c2197edcbae1c4f2844df",
            "user_data_base64": null,
            "user_data_replace_on_change": false,
            "volume_tags": null,
            "vpc_security_group_ids": [
              "sg-07eeab5d0c9340102"
            ]
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6MTIwMDAwMDAwMDAwMCwicmVhZCI6OTAwMDAwMDAwMDAwLCJ1cGRhdGUiOjYwMDAwMDAwMDAwMH0sInNjaGVtYV92ZXJzaW9uIjoiMSJ9",
          "dependencies": [
            "aws_key_pair.ec2_key",
            "aws_security_group.ec2_sg",
            "data.aws_ami.amazon_linux"
          ]
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_key_pair",
      "name": "ec2_key",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:548586340481:key-pair/my-server-key",
            "fingerprint": "ea:d3:e7:9b:6b:bc:db:7a:59:6a:e1:6e:f2:49:b6:5a",
            "id": "my-server-key",
            "key_name": "my-server-key",
            "key_name_prefix": "",
            "key_pair_id": "key-03e272d4b7fc82d5a",
            "key_type": "rsa",
            "public_key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC6m/S6KuVkX+TsA/rSnYIiI1UBOxmVkYkphWE/m6+eiYFu548yKphZDqHDdeFa+h7oHZ0ZoGUCMkW5AJjZ8sRlsXcEK05etzkzuZ5QukgYJrLBckeqKMhxhAGRNkWeVAhBHiDxouYMAvagNXqsUMceSSaY4LxULOFezuvI+e4atsnQlMRtCGA+CDNaS3jLVCm+hOclVMWwZrsMkBeF7GDn1fXrXzpx9AkVYGG0hkarsxZCDrDOwRrIKxEGqGjVkWvU+EW0IkMCVbLcLRTeuRXGW1OzJ/W68l8GKCdC99u7HuSBfvsz97XIPrxPsP+T7XeNhaD3170IaE7AWOzmS2wD root@ip-172-31-1-166",
            "tags": null,
            "tags_all": {}
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "private": "eyJzY2hlbWFfdmVyc2lvbiI6IjEifQ=="
        }
      ]
    },
    {
      "mode": "managed",
      "type": "aws_security_group",
      "name": "ec2_sg",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 1,
          "attributes": {
            "arn": "arn:aws:ec2:us-east-1:548586340481:security-group/sg-07eeab5d0c9340102",
            "description": "Security group for my-server",
            "egress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "",
                "from_port": 0,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "-1",
                "security_groups": [],
                "self": false,
                "to_port": 0
              }
            ],
            "id": "sg-07eeab5d0c9340102",
            "ingress": [
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "HTTP",
                "from_port": 80,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 80
              },
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "HTTPS",
                "from_port": 443,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 443
              },
              {
                "cidr_blocks": [
                  "0.0.0.0/0"
                ],
                "description": "SSH",
                "from_port": 22,
                "ipv6_cidr_blocks": [],
                "prefix_list_ids": [],
                "protocol": "tcp",
                "security_groups": [],
                "self": false,
                "to_port": 22
              }
            ],
            "name": "my-server-sg",
            "name_prefix": "",
            "owner_id": "548586340481",
            "revoke_rules_on_delete": false,
            "tags": {
              "Environment": "dev",
              "Name": "my-server-sg"
            },
            "tags_all": {
              "Environment": "dev",
              "Name": "my-server-sg"
            },
            "timeouts": null,
            "vpc_id": "vpc-010f4b680fd970978"
          },
          "sensitive_attributes": [],
          "identity_schema_version": 0,
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiY3JlYXRlIjo2MDAwMDAwMDAwMDAsImRlbGV0ZSI6OTAwMDAwMDAwMDAwfSwic2NoZW1hX3ZlcnNpb24iOiIxIn0="
        }
      ]
    }
  ],
  "check_results": null
}