module Fog
  module OpenStack
    class Volume
      module Real
        def reset_volume(volume_id, status)
          body = {'os-reset_status' => {'status' => status}}
          request(
            :expects => 202,
            :method  => 'POST',
            :path    => "volumes/#{volume_id}/action",
            :body    => Fog::JSON.encode(body)
          )
        end
      end

      module Mock
        def reset_volume(_volume_id, _status)
          response = Excon::Response.new
          response.status = 202
          response
        end
      end
    end
  end
end
