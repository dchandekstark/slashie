require "yaml"

module Solrbee
  module Api

    def self.config
      @config ||= Mash.new(YAML.load(File.read(File.expand_path('../../../config/api.yml', __FILE__))))
    end

  end
end
