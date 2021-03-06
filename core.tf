## This configuration was generated by terraform-provider-oci

resource oci_core_internet_gateway export_TerraInternetGW {
  compartment_id = var.compartment_ocid
  display_name = "TerraInternetGW"
  enabled      = "true"
  freeform_tags = {
  }
  vcn_id = oci_core_vcn.export_TerraVCN.id
}
resource oci_core_subnet export_TerraSubnet {
  #availability_domain = <<Optional value not found in discovery>>
  cidr_block     = "192.168.101.0/24"
  compartment_id = var.compartment_ocid
  dhcp_options_id = oci_core_vcn.export_TerraVCN.default_dhcp_options_id
  display_name    = "TerraSubnet"
  dns_label       = "terrasubnet"
  freeform_tags = {
  }
  #ipv6cidr_block = <<Optional value not found in discovery>>
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.export_TerraVCN.default_route_table_id
  security_list_ids = [
    oci_core_vcn.export_TerraVCN.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.export_TerraVCN.id
}
resource oci_core_vcn export_TerraVCN {
  cidr_block = "192.168.101.0/24"
  compartment_id = var.compartment_ocid
  display_name = var.vcn_name
  dns_label    = var.vcn_name
  freeform_tags = {
  }
  #ipv6cidr_block = <<Optional value not found in discovery>>
  #is_ipv6enabled = <<Optional value not found in discovery>>
}
resource oci_core_default_dhcp_options export_Default-DHCP-Options-for-TerraVCN {
  display_name = "Default DHCP Options for TerraVCN"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.export_TerraVCN.default_dhcp_options_id
  options {
    custom_dns_servers = [
    ]
    #search_domain_names = <<Optional value not found in discovery>>
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    #custom_dns_servers = <<Optional value not found in discovery>>
    search_domain_names = [
      "terravcn.oraclevcn.com",
    ]
    #server_type = <<Optional value not found in discovery>>
    type = "SearchDomain"
  }
}
resource oci_core_default_route_table export_Default-Route-Table-for-TerraVCN {
  display_name = "Default Route Table for TerraVCN"
  freeform_tags = {
  }
  manage_default_resource_id = oci_core_vcn.export_TerraVCN.default_route_table_id
  route_rules {
    #description = <<Optional value not found in discovery>>
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.export_TerraInternetGW.id
  }
}
resource oci_core_default_security_list export_Default-Security-List-for-TerraVCN {
  display_name = "Default Security List for TerraVCN"
  egress_security_rules {
    #description = <<Optional value not found in discovery>>
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    #icmp_options = <<Optional value not found in discovery>>
    protocol  = "all"
    stateless = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  freeform_tags = {
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
      #source_port_range = <<Optional value not found in discovery>>
    }
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "192.168.101.0/24"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  manage_default_resource_id = oci_core_vcn.export_TerraVCN.default_security_list_id
}

resource oci_core_instance export_Webserver {
  availability_domain = "LYXg:EU-FRANKFURT-1-AD-1"
  compartment_id      = var.compartment_ocid
  create_vnic_details {
    assign_public_ip = "true"
    display_name = var.web_host_name
    hostname_label = var.web_host_name
    skip_source_dest_check = "false"
    subnet_id              = oci_core_subnet.export_TerraSubnet.id
  }
  display_name = "Webserver"
  fault_domain = "FAULT-DOMAIN-1"
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = "true"
    network_type                        = "VFIO"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }
  metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCg93rI0IydrdqDyPu4b/BoKraAPogEHSMGaeu2D6XmHkFJL69MnDXa1ihLsFIg9R3yFeTYLSP3D4VWD088BW7tjDbqnRE5k2TkoTnEp7KvG1lyTOg+/CovNO6BGbV2JBq0tlFSjSN/CsDllljdpGmZVImpMxCCL/6R8NE7EXFZpZB/mIlZJib5c55THrv/aK9l6qJOvU6000C9p6jitj2E16laznDd1TBR+3lD6wiJlLj7hRFqM5F6e7oLeuwANwfDFwyXNuCfXTnr2VSVs7uiNItylxwmdWZn0eltXpBiwttTcmZ5Im2G6oyZRvj4AnkPacAQM8i74l3/OxNLIgYL phpseclib-generated-key"
  }
  shape = "VM.Standard.E3.Flex"
  shape_config {
    memory_in_gbs = var.memory
    ocpus         = "1"
  }
  source_details {
    source_id   = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaadufxapj27ujdt7qqye7qxiozk7uucutigc7lh6nwljd3nw43qosq"
    source_type = "image"
  }
}



