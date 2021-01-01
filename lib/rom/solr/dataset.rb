module ROM
  module Solr
    class Dataset < ROM::HTTP::Dataset

      setting :default_content_type, reader: true
      setting :default_base_path, reader: true
      setting :default_params, reader: true

      configure do |config|
        config.default_response_handler = ResponseHandler
        config.default_request_handler  = RequestHandler
      end

      option :request_data, type: Types::String, default: proc { EMPTY_STRING }
      option :content_type, type: Types::String, default: proc { self.class.default_content_type }

      # @override
      option :base_path, type: Types::Path, default: proc { self.class.default_base_path || EMPTY_STRING }

      # @override
      option :params, type: Types::Hash, default: proc { self.class.default_params || EMPTY_HASH }

      # @override Query parameters are valid with POST, too.
      def uri
        uri_s = [options[:uri], path].compact.reject(&:empty?).join('/')

        URI(uri_s).tap do |u|
          u.query = param_encoder.call(params) if params?
        end
      end

      def with_request_data(data)
        with_options(request_data: data)
      end

      # Copies and makes private superclass #response method
      alias_method :__response__, :response
      private :__response__

      # @override Cache response by default
      def response
        cache.fetch_or_store(:response) { __response__ }
      end

      def response_header(key)
        response.dig(:responseHeader, key)
      end

      def request_data?
        !request_data.nil? && !request_data.empty?
      end

      def params?
        params.any?
      end

      def status
        response_header(:status)
      end

      def qtime
        response_header(:QTime)
      end

      def append_param_values(param, values)
        param_values = Array.wrap(params[param])
        new_values = Array.wrap(values)

        add_params param => (param_values + new_values)
      end

      private

      def cache
        @cache ||= Concurrent::Map.new
      end

    end
  end
end
