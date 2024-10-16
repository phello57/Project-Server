require 'rack'
require 'faraday'
require 'base64'
require 'sqlite3'
require 'bcrypt'
require './sql/sql_init'


class App
  def initialize
    @db = SqlInit.new.init
  end

  def call(env)
    req_login, req_pass = get_req_login_pass(env)
    pass_from_db = get_pass_from_db(req_login)

    if BCrypt::Password.new(pass_from_db) == req_pass
      [200, { 'Content-Type' => 'text/plain' }, ['You authentication']]
    else
      [401, { 'Content-Type' => 'text/plain' }, ['You aren`t authentication']]
    end
  end

  def get_req_login_pass(env)
    auth = Rack::Request.new(env).env['HTTP_AUTHORIZATION']
    Base64.decode64(auth&.split&.last).split(':')
  end

  def get_pass_from_db(login)
    @db.execute("select password from users where username = \"#{login}\"")[0][0]
  end
end

Rackup::Handler::WEBrick.run App.new
