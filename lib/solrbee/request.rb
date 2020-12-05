module Solrbee
  class Request

    attr_reader :client, :path, :data, :params

    def self.execute(*args)
      new(*args).execute
    end

    def initialize(client, path, data: nil, params: {})
      @client = client
      @path = path
      @data = data
      @params = params
    end

    def request_class
      data ? Net::HTTP::Post : Net::HTTP::Get
    end

    def headers
      Hash.new.tap do |h|
        h['Accept']       = 'application/json'
        h['Content-Type'] = 'application/json' if data
      end
    end

    def uri
      client.uri.dup.tap do |u|
        u.path += path
        unless params.empty?
          u.query = URI.encode_www_form(params)
        end
      end
    end

    def execute
      req = request_class.new(uri, headers)
      req.body = JSON.dump(data) if data
      http_response = client.connection.request(req)
      Response.new JSON.parse(http_response.body)
    end

  end
end
