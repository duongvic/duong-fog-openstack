require 'fog/openstack/models/collection'
require 'fog/openstack/octavia/models/load_balancer'

module Fog
  module OpenStack
    class Octavia
      class LoadBalancerL7policy < Fog::OpenStack::Collection
        attribute :filters

         # TODO: Change to l7policy models
        model Fog::OpenStack::Octavia::LoadBalancer

        def initialize(attributes)
          self.filters ||= {}
          super
        end

        def all(filters_arg = filters)
          filters = filters_arg
          load_response(service.list_lbaas_l7policies(filters), 'load_balancer_l7policies')
        end

        def get(vip_id)
          if vip = service.get_lbaas_l7policy(vip_id).body['load_balancer_l7policiy']
            new(vip)
          end
        rescue Fog::OpenStack::Octavia::NotFound
          nil
        end
      end
    end
  end
end
