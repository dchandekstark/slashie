module ROM
  module Solr
    class RequestHandler

      def self.call(dataset)
        uri = URI(dataset.uri)

        unless dataset.params.empty?
          uri.query = URI.encode_www_form(dataset.params)
        end

        headers = dataset.headers.transform_keys(&:to_s)

        request_class = Net::HTTP.const_get(ROM::Inflector.classify(dataset.request_method))

        request = request_class.new(uri.request_uri, headers)

        if dataset.has_request_data?
          request.body = dataset.request_data
          request.content_type = dataset.content_type
        end

        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme.eql?('https')) do |http|
          http.request(request)
        end
      end

    end
  end
end
