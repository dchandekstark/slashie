module ROM
  module Solr
    class RequestHandler

      def self.call(dataset)
        uri = URI(dataset.uri)
        uri.query = URI.encode_www_form(dataset.params)

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true if uri.scheme.eql?('https')

        request_class = Net::HTTP.const_get(ROM::Inflector.classify(dataset.request_method))
        request = request_class.new(uri.request_uri)

        dataset.headers.each_with_object(request) do |(header, value), request|
          request[header.to_s] = value
        end

        http.request(request)
      end

    end
  end
end
