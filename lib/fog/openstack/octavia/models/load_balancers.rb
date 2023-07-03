require 'fog/openstack/models/collection'
require 'fog/openstack/octavia/models/load_balancer'

module Fog
  module OpenStack
    class Octavia
      class LoadBalancers < Fog::OpenStack::Collection
        attribute :filters

        model Fog::OpenStack::Octavia::LoadBalancer

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lbaas_loadbalancers(filters), 'loadbalancers')
        end

        def get(vip_id)
          if vip = service.get_lbaas_loadbalancer(vip_id).body['loadbalancers']
            new(vip)
          end
        rescue Fog::OpenStack::Network::NotFound
          nil
        end
      end
    end
  end
end
