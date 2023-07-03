

module Fog
  module OpenStack
    class Octavia < Fog::Service
      requires :openstack_auth_url
      recognizes :openstack_auth_token, :openstack_management_url,
                 :persistent, :openstack_service_type, :openstack_service_name,
                 :openstack_tenant, :openstack_tenant_id,
                 :openstack_api_key, :openstack_username, :openstack_identity_endpoint,
                 :current_user, :current_tenant, :openstack_region,
                 :openstack_endpoint_type, :openstack_cache_ttl,
                 :openstack_project_name, :openstack_project_id,
                 :openstack_project_domain, :openstack_user_domain, :openstack_domain_name,
                 :openstack_project_domain_id, :openstack_user_domain_id, :openstack_domain_id,
                 :openstack_identity_api_version

      ## MODELS
      #
      model_path 'fog/openstack/octavia/models'
      collection  :load_balancer_pools
      collection  :load_balancer_pool_members
      collection  :lb_health_monitors
      collection  :load_balancers
      collection  :load_balancer_l7rules
      collection  :load_balancer_l7policy
      collection  :load_balancer_listeners

      ## REQUESTS
      request_path 'fog/openstack/octavia/requests'

      # LBaaS V2

      # LBaaS V2 Loadbanacer
      request :list_lbaas_loadbalancers
      request :create_lbaas_loadbalancer
      request :delete_lbaas_loadbalancer
      request :get_lbaas_loadbalancer
      request :update_lbaas_loadbalancer

      # LBaaS V2 Listener
      request :list_lbaas_listeners
      request :create_lbaas_listener
      request :delete_lbaas_listener
      request :get_lbaas_listener
      request :update_lbaas_listener

      # LBaaS V2 Pool
      request :list_lbaas_pools
      request :create_lbaas_pool
      request :delete_lbaas_pool
      request :get_lbaas_pool
      request :update_lbaas_pool

      # LBaaS V2 Pool_Member
      request :list_lbaas_pool_members
      request :create_lbaas_pool_member
      request :delete_lbaas_pool_member
      request :get_lbaas_pool_member
      request :update_lbaas_pool_member

      # LBaaS V2 Healthmonitor
      request :list_lbaas_healthmonitors
      request :create_lbaas_healthmonitor
      request :delete_lbaas_healthmonitor
      request :get_lbaas_healthmonitor
      request :update_lbaas_healthmonitor

      # LBaaS V2 L7Policy
      request :list_lbaas_l7policies
      request :create_lbaas_l7policy
      request :delete_lbaas_l7policy
      request :get_lbaas_l7policy
      request :update_lbaas_l7policy

      # LBaaS V2 L7Rule
      request :list_lbaas_l7rules
      request :create_lbaas_l7rule
      request :delete_lbaas_l7rule
      request :get_lbaas_l7rule
      request :update_lbaas_l7rule

      # Tenant
      request :set_tenant

      # Quota
      request :get_quotas
      request :get_quota
      request :update_quota
      request :delete_quota

      class Mock
        def self.data
          @data ||= Hash.new do |hash, key|
            qos_policy_id = Fog::UUID.uuid
            network_id   = Fog::UUID.uuid
            extension_id = Fog::UUID.uuid
            subnet_id    = Fog::UUID.uuid
            tenant_id    = Fog::Mock.random_hex(8)

            hash[key] = {
              :extensions             => {
                extension_id => {
                  'id'          => extension_id,
                  'alias'       => 'dvr',
                  'description' => 'Enables configuration of Distributed Virtual Routers.',
                  'links'       => [],
                  'name'        => 'Distributed Virtual Router'
                }
              },
              :networks               => {
                network_id                => {
                  'id'                    => network_id,
                  'name'                  => 'Public',
                  'subnets'               => [subnet_id],
                  'shared'                => true,
                  'status'                => 'ACTIVE',
                  'tenant_id'             => tenant_id,
                  'provider:network:type' => 'vlan',
                  'router:external'       => false,
                  'admin_state_up'        => true,
                  'qos_policy_id'         => qos_policy_id,
                  'port_security_enabled' => true
                },
                'e624a36d-762b-481f-9b50-4154ceb78bbb' => {
                  'id'                    => 'e624a36d-762b-481f-9b50-4154ceb78bbb',
                  'name'                  => 'network_1',
                  'subnets'               => ['2e4ec6a4-0150-47f5-8523-e899ac03026e'],
                  'shared'                => false,
                  'status'                => 'ACTIVE',
                  'tenant_id'             => 'f8b26a6032bc47718a7702233ac708b9',
                  'provider:network:type' => 'vlan',
                  'router:external'       => false,
                  'admin_state_up'        => true,
                  'qos_policy_id'         => qos_policy_id,
                  'port_security_enabled' => true
                }
              },
              :ports                  => {},
              :subnets                => {
                subnet_id => {
                  'id'               => subnet_id,
                  'name'             => "Public",
                  'network_id'       => network_id,
                  'cidr'             => "192.168.0.0/22",
                  'ip_version'       => 4,
                  'gateway_ip'       => Fog::Mock.random_ip,
                  'allocation_pools' => [],
                  'dns_nameservers'  => [Fog::Mock.random_ip, Fog::Mock.random_ip],
                  'host_routes'      => [Fog::Mock.random_ip],
                  'enable_dhcp'      => true,
                  'tenant_id'        => tenant_id,
                }
              },
              :subnet_pools           => {},
              :floating_ips           => {},
              :routers                => {},
              :lb_pools               => {},
              :lb_members             => {},
              :lb_health_monitors     => {},
              :lb_vips                => {},
              :lbaas_loadbalancers    => {},
              :lbaas_listeners        => {},
              :lbaas_pools            => {},
              :lbaas_pool_members     => {},
              :lbaas_health_monitorss => {},
              :lbaas_l7policies       => {},
              :lbaas_l7rules          => {},
              :vpn_services           => {},
              :ike_policies           => {},
              :ipsec_policies         => {},
              :ipsec_site_connections => {},
              :rbac_policies          => {},
              :quota                  => {
                "subnet"     => 10,
                "router"     => 10,
                "port"       => 50,
                "network"    => 10,
                "floatingip" => 50
              },
              :quotas                 => [
                {
                  "subnet"     => 10,
                  "network"    => 10,
                  "floatingip" => 50,
                  "tenant_id"  => tenant_id,
                  "router"     => 10,
                  "port"       => 30
                }
              ],
              :security_groups            => {},
              :security_group_rules       => {},
              :network_ip_availabilities  => [
                {
                  "network_id"              => "4cf895c9-c3d1-489e-b02e-59b5c8976809",
                  "network_name"            => "public",
                  "subnet_ip_availability"  => [
                    {
                      "cidr"          => "2001:db8::/64",
                      "ip_version"    => 6,
                      "subnet_id"     => "ca3f46c4-c6ff-4272-9be4-0466f84c6077",
                      "subnet_name"   => "ipv6-public-subnet",
                      "total_ips"     => 18446744073709552000,
                      "used_ips"      => 1
                    },
                    {
                      "cidr"          => "172.24.4.0/24",
                      "ip_version"    => 4,
                      "subnet_id"     => "cc02efc1-9d47-46bd-bab6-760919c836b5",
                      "subnet_name"   => "public-subnet",
                      "total_ips"     => 253,
                      "used_ips"      => 1
                    }
                  ],
                  "project_id"  => "1a02cc95f1734fcc9d3c753818f03002",
                  "tenant_id"   => "1a02cc95f1734fcc9d3c753818f03002",
                  "total_ips"   => 253,
                  "used_ips"    => 2
                },
                {
                  "network_id"              => "6801d9c8-20e6-4b27-945d-62499f00002e",
                  "network_name"            => "private",
                  "subnet_ip_availability"  => [
                    {
                      "cidr"        => "10.0.0.0/24",
                      "ip_version"  => 4,
                      "subnet_id"   => "44e70d00-80a2-4fb1-ab59-6190595ceb61",
                      "subnet_name" => "private-subnet",
                      "total_ips"   => 253,
                      "used_ips"    => 2
                    },
                    {
                      "ip_version"  => 6,
                      "cidr"        => "fdbf:ac66:9be8::/64",
                      "subnet_id"   => "a90623df-00e1-4902-a675-40674385d74c",
                      "subnet_name" => "ipv6-private-subnet",
                      "total_ips"   => 18446744073709552000,
                      "used_ips"    => 2
                    }
                  ],
                  "project_id"  => "d56d3b8dd6894a508cf41b96b522328c",
                  "tenant_id"   => "d56d3b8dd6894a508cf41b96b522328c",
                  "total_ips"   => 18446744073709552000,
                  "used_ips"    => 4
                }
              ]
            }
          end
        end

        def self.reset
          @data = nil
        end

        include Fog::OpenStack::Core

        def initialize(options = {})
          @auth_token = Fog::Mock.random_base64(64)
          @auth_token_expiration = (Time.now.utc + 86400).iso8601
        end

        def data
          self.class.data["#{@openstack_username}-#{@openstack_tenant}"]
        end

        def reset_data
          self.class.data.delete("#{@openstack_username}-#{@openstack_tenant}")
        end
      end

      class Real
        include Fog::OpenStack::Core

        def self.not_found_class
          Fog::OpenStack::Network::NotFound
        end

        def default_path_prefix
          'v2.0'
        end

        def default_service_type
          %w[load-balancer]
        end
      end
    end
  end
end
