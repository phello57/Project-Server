# frozen_string_literal: true

require 'rack'
require 'faraday'
require 'base64'
require 'sqlite3'
require 'bcrypt'
require './sql_init'

class App
  def initialize
    @db = SqlInit.new.init
  end

  def call(env)
    req_login, req_pass = parse_credentials(env)

    pass_from_db = fetch_password_hash(req_login.to_sym.to_s)

    if pass_from_db != nil && BCrypt::Password.new(pass_from_db) == req_pass
      [200, { 'Content-Type' => 'text/plain' }, ['You authentication']]
    else
      [401, { 'Content-Type' => 'text/plain' }, ['You aren`t authentication']]
    end
  end

  def parse_credentials(env)
    auth = Rack::Request.new(env).env['HTTP_AUTHORIZATION']
    Base64.decode64(auth&.split&.last).split(':')
  end

  def fetch_password_hash(login)
     @db.execute("select password from users where username = ? ", login).first&.first
  end

end

Rackup::Handler::WEBrick.run App.new
