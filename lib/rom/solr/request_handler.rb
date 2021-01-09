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
        Solrbee.logger.debug { "Dataset: #{dataset.inspect}" }

        Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme.eql?('https')) do |http|
          Solrbee.logger.debug { "%s: %s %s" % [self.class, request.method, uri.request_uri] }

          http.request(request)
        end
      end

      def request
        @request ||= request_class.new(uri.request_uri, headers).tap do |req|
          if dataset.request_data?
            req.body = dataset.request_data
            req.content_type = dataset.content_type

            if req.content_type == 'application/json'
              Solrbee.logger.debug { "Request data: %s" % req.body[0..99] + (req.body.length > 100 ? ' ...' : '') }
            end
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
