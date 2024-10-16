require 'rack'
require 'faraday'
require 'json'

echo_url = "https://echo.free.beeceptor.com/?"

app = proc do |env|
  add_params = Rack::Utils.build_query(Rack::Request.new(env).params)

  response = Faraday.get(echo_url + add_params)

  [200, { 'Content-Type' => 'text/plain' }, [JSON.parse(response.body)["parsedQueryParams"].to_s ]]
end

Rackup::Handler::WEBrick.run app

