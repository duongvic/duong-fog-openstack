require 'fog/openstack/models/collection'
require 'fog/openstack/network/models/lb_pool'

module Fog
  module OpenStack
    class Octavia
      class LoadBalancerPools < Fog::OpenStack::Collection
        attribute :filters

        model Fog::OpenStack::Network::LbPool

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lbaas_pools(filters), 'pools')
        end

        def get(pool_id)
          if pool = service.get_lbaas_pool(pool_id).body['pool']
            new(pool)
          end
        rescue Fog::OpenStack::Octavia::NotFound
          nil
        end
      end
    end
  end
end
