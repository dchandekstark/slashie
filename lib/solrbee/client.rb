require "net/http"
require "uri"
require "json"

require "solrbee/api_methods"

module Solrbee
  class Client
    include ApiMethods

    attr_reader :collection, :uri

    def initialize(collection)
      @collection = collection
      @uri = URI(Solrbee.solr_url).tap do |u|
        u.path += '/%s' % URI.encode_www_form_component(collection)
      end
    end

    def connection
      Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl = true if uri.scheme == 'https'
      end
    end

    def cursor
      Cursor.new(self)
    end

  end
end
