require 'fog/openstack/models/collection'
require 'fog/openstack/network/models/lb_pool'

module Fog
  module OpenStack
    class Octavia
      class LoadBalancerListeners < Fog::OpenStack::Collection
        attribute :filters

        # TODO: Change to listener models
        model Fog::OpenStack::Network::LbPool

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lbaas_listeners(filters), 'listeners')
        end

        def get(listener_id)
          if listener = service.get_lbaas_listener(pool_id).body['listener']
            new(listener)
          end
        rescue Fog::OpenStack::Octavia::NotFound
          nil
        end
      end
    end
  end
end
