module ROM
  module Solr
    class Dataset < ROM::HTTP::Dataset

      # Default query parameters
      setting :default_params, EMPTY_HASH, reader: true
      option :params, type: Types::Hash, default: ->{ self.class.default_params }

      # Request and response handlers
      config.default_response_handler = ResponseHandler
      config.default_request_handler = RequestHandler

      # @override Handles nil
      def with_path(path)
        return self if path.nil?
        super
      end

      # Coerce param value to an Array and set new value
      # to set union with other Array of values.
      def add_param_values(key, val)
        new_val = Array.wrap(params[key]) | Array.wrap(val)
        add_params(key => new_val)
      end

      # @override
      def add_params(new_params = {})
        return self if new_params.nil? || new_params.empty?
        with_params params.merge(new_params).compact
      end

      # @override Seems good to have no-op when params not changed?
      def with_params(new_params)
        return self if params == new_params
        with_options(params: new_params)
      end

      # Copies and makes private superclass #response method
      alias_method :__response__, :response
      private :__response__

      # @override Cache response by default
      def response
        cache.fetch_or_store(:response) { __response__ }
      end

      private

      def cache
        @cache ||= Concurrent::Map.new
      end

    end
  end
end
