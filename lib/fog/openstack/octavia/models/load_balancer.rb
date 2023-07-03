require 'fog/openstack/models/model'

module Fog
  module OpenStack
    class Octavia
      class LoadBalancer < Fog::OpenStack::Model
        identity :id

        attribute :name
        attribute :description
        attribute :tenant_id

        def destroy
          requires :id
          service.delete_load_balancers(id)
          true
        end

        def save
          merge_attributes(service.create_load_balancers(attributes).body['load_balancers'])
          self
        end

        def update
          requires :id
          merge_attributes(service.update_load_balancers(id, attributes).body['load_balancers'])
          self
        end
      end
    end
  end
end
