require 'rack'
require 'faraday'
require "base64"

class App
  LOGIN_FROM_BD = 'phello'
  PASS_FROM_BD = 'qwerty123'
  def call(env)

    auth = Rack::Request.new(env).env["HTTP_AUTHORIZATION"]

    log_pass = Base64.decode64(auth&.split&.last).split(':')

    if log_pass[0] == LOGIN_FROM_BD && log_pass[1] == PASS_FROM_BD
      [200, { 'Content-Type' => 'text/plain' }, ["You authorization"]]
    else
      [403, { 'Content-Type' => 'text/plain' }, ["You aren`t authorization"]]
    end

  end
end

Rackup::Handler::WEBrick.run App.new
