module ROM
  module Solr
    class Dataset < ROM::HTTP::Dataset

      setting :default_response_key, reader: true

      setting :default_headers, reader: true

      configure do |config|
        config.default_response_handler = ResponseHandler
        config.default_request_handler  = RequestHandler
        config.default_headers = { Accept: 'application/json' }
      end

      option :response_key, default: proc { self.class.default_response_key }

      option :headers, type: Types::Hash, default: proc { self.class.default_headers }

      # @override
      def each(&block)
        return to_enum unless block_given?

        enumerable_data.each(&block)
      end

      def with_response_key(*path)
        with_options(response_key: path)
      end

      # Copies and makes private superclass #response method
      alias_method :__response__, :response
      private :__response__

      # @override Cache response by default
      def response
        cache.fetch_or_store(:response) { __response__ }
      end

      private

      def enumerable_data
        Array.wrap(response_key ? response.dig(*response_key) : response)
      end

      def cache
        @cache ||= Concurrent::Map.new
      end

    end
  end
end
