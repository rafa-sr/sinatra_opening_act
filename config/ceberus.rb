# frozen_string_literal: true

require 'yaml'
require 'erb'

class Cerberus
  def self.config
    @config ||= begin
      raw_yaml = File.open('config/cerberus.yml').read
      content = ERB.new(raw_yaml).result
      YAML.safe_load(content,
                     [],
                     [],
                     true)[Sinatra::Base.environment.to_s].freeze
    end
  end
end
