module ROM
  module Solr
    class RequestHandler

      def self.call(dataset)
        new(dataset).execute
      end

      attr_reader :dataset

      def initialize(dataset)
        @dataset = dataset
      end

      def execute
        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme.eql?('https')) do |http|
          http.request(request)
        end
      end

      def request
        request_class.new(uri.request_uri, headers).tap do |req|
          if dataset.request_data?
            req.body = dataset.request_data
            req.content_type = dataset.content_type
          end
        end
      end

      def headers
        dataset.headers.transform_keys(&:to_s)
      end

      def uri
        @uri ||= URI(dataset.uri).tap do |u|
          if dataset.params?
            u.query ||= dataset.param_encoder.call(dataset.params)
          end
        end
      end

      def request_class
        if dataset.request_data?
          Net::HTTP::Post
        else
          Net::HTTP::Get
        end
      end

    end
  end
end
