require "bundler"
Bundler.require

require "sinatra/base"
require "json"
require "http"

# Example app for presentation purpose
class App < Sinatra::Application
  set :auth_token, ENV["SERVICE_TOKEN"]
  set :service_address, ENV["SERVICE_ADDRESS"]

  get "/" do
    resp = HTTP.auth(settings.auth_token).get(settings.service_address).body
    resp = JSON.parse(resp)

    networks = Socket.ip_address_list.map(&:getnameinfo).map(&:first)

    erb :index, locals: { service_response: resp, networks: networks }
  end
end
