require 'rack'

app = proc do |env|
  req = Rack::Request.new(env)

  response_body = ''
  req.params.each { |key, value| response_body += "#{key} : #{value}\n " }

  [200, { 'Content-Type' => 'text/html' }, [response_body]]
end

Rackup::Handler::WEBrick.run app
