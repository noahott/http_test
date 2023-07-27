# frozen_string_literal: true

require 'sinatra'
require 'json'

WAIT_TIME = 10 #seconds

before do
  content_type :json
end

def wait = proc do
  time = WAIT_TIME.to_i
  sleep(time)
  {
    route: request.path_info,
    method: request.request_method,
    message: "Slept #{time} seconds at #{Time.now}"
  }.to_json
end

def error = proc do
  [ # return specific error
    418,
    {
      route: request.path_info,
      method: request.request_method,
      message: "Returning error code"
    }.to_json
  ]
end

get '/' do
  { message: 'Hello world!' }.to_json
end

get '/wait/:time' do |time|
  time = time.to_i
  sleep(time)
  { message: "Slept #{time} seconds at #{Time.now}" }.to_json
end

get '/*', {}, &wait
post '/*', {}, &wait
put '/*', {}, &wait
delete '/*', {}, &wait