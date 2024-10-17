# frozen_string_literal: true

require 'rack'
require 'faraday'
require 'base64'
require 'sqlite3'
require 'bcrypt'
require 'json'

class App
  ECHO_URL = 'https://echo.free.beeceptor.com'
  def initialize
    @db = SQLite3::Database.new('test.db')
    @request = nil
  end

  def call(env)
    @request = Rack::Request.new(env)

    if @request.get? && @request.path == '/token'

      # === User data ===
      req_login, req_pass = parse_credentials
      db_id, db_pass = fetch_user_data(req_login.to_sym.to_s)
      !db_pass.nil? && BCrypt::Password.new(db_pass) == req_pass

      # === Token ===
      json = { "id_user": db_id, "login": req_login }.to_json
      token = Base64.encode64(json).delete("\n")

      # === Result ===

      json_responce = { token: token, userdata: json }.to_json

      [200, { 'Content-Type' => 'application/json' }, [json_responce]]
    else

      json_string = @request.params.to_json
      parsed_params = JSON.parse(json_string)

      user_data = Base64.decode64(parsed_params['token'])
      parsed_user_data = JSON.parse(user_data)

      is_user_auth = fetch_user_exists(parsed_user_data) == 1

      # === Echo ===
      send_echo({ token: token }.to_json)


      if is_user_auth
        [200, { 'Content-Type' => 'text/plain' }, ['You authentication was successful']]
      else
        [401, { 'Content-Type' => 'text/plain' }, [parsed_user_data['login']]]
      end
    end
  end

  def parse_credentials
    auth = @request.env['HTTP_AUTHORIZATION']
    Base64.decode64(auth.split&.last).split(':')
  end

  def send_echo(data)
    Faraday.post(ECHO_URL) do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = data
    end
  end

  def fetch_user_data(login)
    @db.execute('select id, password from users where username = ? ', login).first
  end

  def fetch_user_exists(data)
    @db.execute('select 1 from users where id = ? ', data['id_user']).first&.first
  end
end

Rackup::Handler::WEBrick.run App.new
