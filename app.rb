# frozen_string_literal: true

require 'bundler'
Bundler.require :default
MultiJson.use :oj

require_all 'config/**.rb'
# require_all 'services/**/*.rb'
# require_all 'models/**.rb'
# require_all 'serializers/**.rb'
require_all 'controllers/**.rb'

require 'sinatra'
require 'sinatra/namespace'
require 'sinatra/cross_origin'
# use Raven::Rack
use Config::CustomDefaultType
use Rack::JSON

require_relative 'config/rack_json'
