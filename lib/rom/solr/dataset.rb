module ROM
  module Solr
    class Dataset < ROM::HTTP::Dataset

      setting :default_data_path, reader: true

      configure do |config|
        config.default_response_handler = ResponseHandler
        config.default_request_handler  = RequestHandler
      end

      option :data_path, default: proc { self.class.default_data_path }

      # @override
      def each(&block)
        return to_enum unless block_given?

        enumerable_data.each(&block)
      end

      def with_data_path(*path)
        with_options(data_path: path)
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
        Array.wrap(data_path ? response.dig(*data_path) : response)
      end

      def cache
        @cache ||= Concurrent::Map.new
      end

    end
  end
end
