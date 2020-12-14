require "net/http"
require "uri"
require "json"

module Solrbee
  class Client

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

    # Generate API methods
    Solrbee.api.each do |name, config|
      path = config.fetch('path')
      data = config['data']

      define_method(name.to_sym) do |args = {}|
        response = request(
          path: path % args,
          params: args.fetch(:params, {}),
          data: args[:data]
        )
        ( k = config['response_key'] ) ? response[k] : response
      end
    end

    def index(*docs, **params)
      request(path: '/update/json/docs', data: docs, params: params)
    end
    alias_method :add, :index
    alias_method :update, :index

    def query(**params)
      request(path: '/query', data: params)
    end

    #
    # Schema methods
    #
    def field_names
      fields.map { |f| f['name'] }
    end

    def field_type_names
      field_types.map { |f| f['name'] }
    end

    def add_field(field)
      schema(data: {"add-field"=>field})
    end

    def delete_field(name)
      schema(data: {"delete-field"=>name})
    end

    def replace_field(field)
      schema(data: {"replace-field"=>{"name"=>field}})
    end

    #
    # Update methods
    #
    def delete_by_id(*ids)
      update(data: {delete: ids})
    end

  end
end
