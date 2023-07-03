require 'fog/openstack/models/collection'
require 'fog/openstack/octavia/models/load_balancer'

module Fog
  module OpenStack
    class Octavia
      class LoadBalancerL7rules < Fog::OpenStack::Collection
        attribute :filters

        # TODO: Change to l7rules models
        model Fog::OpenStack::Octavia::LoadBalancer

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lbaas_l7rules(filters), 'load_balancer_l7rules')
        end

        def get(load_balancer_id)
          if load_balancer_l7rule = service.get_lbaas_l7rule(load_balancer_id).body['load_balancer_l7rule']
            new(load_balancer_l7rule)
          end
        rescue Fog::OpenStack::Octavia::NotFound
          nil
        end
      end
    end
  end
end
