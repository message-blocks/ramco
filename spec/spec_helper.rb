# encoding: UTF-8
require 'bundler'
Bundler.require :default, :test
require 'webmock/rspec'
require 'vcr'
require 'ramco'
require 'pry'

VCR.configure do |c|
  c.cassette_library_dir = File.expand_path('../responses', __FILE__)
  c.hook_into :webmock
  c.default_cassette_options = {:record => :once}
  c.allow_http_connections_when_no_cassette = true
end
if File.exists? File.expand_path("../settings.yml", __FILE__)
  settings = YAML.load_file(File.expand_path('../settings.yml', __FILE__))
  RAMCO_KEY = settings['api_key']
else
  RAMCO_KEY = ENV["RAMCO_KEY"]
end
class Guid
  def self.guid
    UUIDTools::UUID.timestamp_create().to_s
  end
end