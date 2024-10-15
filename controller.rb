
require 'rack'

app = Proc.new do |env|

	req = Rack::Request.new(env)

	response_body = req.post? ? "POST\n" : "GET\n"
	req.params.each { |key, value| response_body += "#{key} : #{value}\n " }

	[200, { 'Content-Type' => 'text/html' }, [response_body]]
end

Rackup::Handler::WEBrick.run app