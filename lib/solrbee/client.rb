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

    def request(method, path, **params)
      req_uri = uri.dup
      req_uri.path += path
      unless params.empty?
        req_uri.query = URI.encode_www_form RequestParams.new(params)
      end
      req = request_class(method).new(req_uri, {'Accept'=>'application/json'})
      yield req if block_given?
      res = connection.request(req)
      Response.new JSON.parse(res.body)
    end

    def get(path, **params)
      request(:get, path, **params)
    end

    def post(path, data, **params)
      request(:post, path, **params) do |req|
        req['Content-Type'] = 'application/json'
        req.body = JSON.dump(data)
      end
    end

    def cursor
      Cursor.new(self)
    end

  end
end
