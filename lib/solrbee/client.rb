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

    # :get -> Net::HTTP::Get
    def request_class(method)
      Net::HTTP.const_get(method.to_s.downcase.capitalize)
    end

    def request(method, path)
      full_path = uri.path + path
      req = request_class(method).new(full_path, {'Accept'=>'application/json'})
      yield req if block_given?
      res = connection.request(req)
      Response.new JSON.parse(res.body)
    end

    def get(path)
      request(:get, path)
    end

    def post(path, data)
      request(:post, path) do |req|
        req['Content-Type'] = 'application/json'
        req.body = JSON.dump(data)
      end
    end

    def cursor
      Cursor.new(self)
    end

  end
end
