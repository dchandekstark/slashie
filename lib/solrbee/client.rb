require "net/http"
require "uri"
require "json"

require "solrbee/api_methods"

module Solrbee
  class Client
    include ApiMethods

    attr_reader :uri

    def self.cursor(url: nil)
      new(url: url).cursor
    end

    def initialize(url: nil)
      @uri = URI(url || ENV['SOLR_URL'])
    end

    def connection
      Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl = true if uri.scheme == 'https'
      end
    end

    def cursor
      Cursor.new(self)
    end

    def request(path:, data: nil, params: {})
      req_class = data ? Net::HTTP::Post : Net::HTTP::Get

      req_uri = uri.dup.tap do |u|
        u.path += path
        u.query = URI.encode_www_form(params) unless params.empty?
      end

      req = req_class.new(req_uri)
      req['Accept'] = 'application/json'

      if data
        req['Content-Type'] = 'application/json'
        req.body = JSON.dump(data)
      end

      http_response = connection.request(req)
      JSON.parse(http_response.body)
    end

  end
end
