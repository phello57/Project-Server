require 'rack'
require 'faraday'

ECHO_URL = "https://echo.free.beeceptor.com"

class App
  def call(env)
    response =  Faraday.post(ECHO_URL) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = Rack::Request.new(env).params.to_json
    end

    [200, { 'Content-Type' => 'text/plain' }, [response.body.to_s]]
  end
end

Rackup::Handler::WEBrick.run App.new
