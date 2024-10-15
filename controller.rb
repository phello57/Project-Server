require 'rack'

app = proc do |env|
  [200, { 'Content-Type' => 'text/plain' }, [Rack::Request.new(env).params.to_s]]
end

Rackup::Handler::WEBrick.run app


