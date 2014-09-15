require 'sinatra/base'
require 'rack/request_replication'

$destination_responses ||= []

class TestApp < Sinatra::Base
  set :port, 4567

  enable :logging

  use Rack::RequestReplication::Forwarder, port: 4568

  get '/' do
    'GET OK'
  end

  post '/' do
    'POST OK'
  end

  put '/' do
    'PUT OK'
  end

  patch '/' do
    'PATCH OK'
  end

  delete '/' do
    'DELETE OK'
  end

  options '/' do
    'OPTIONS OK'
  end
end

class DestApp < Sinatra::Base
  set :port, 4568

  enable :logging

  get '/' do
    $destination_responses << 'GET OK'
    'Hello, World!'
  end

  post '/' do
    $destination_responses << 'POST OK'
    'Created!'
  end

  put '/' do
    $destination_responses << 'PUT OK'
    'Replaced!'
  end

  patch '/' do
    $destination_responses << 'PATCH OK'
    'Updated'
  end

  delete '/' do
    $destination_responses << 'DELETE OK'
    'Removed!'
  end

  options '/' do
    $destination_responses << 'OPTIONS OK'
    'Appeased!'
  end
end