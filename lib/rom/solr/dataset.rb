module ROM
  module Solr
    class Dataset < ROM::HTTP::Dataset

      # Key or array of keys to pass to response.dig(*keys)
      # for enumeration of the dataset values.
      setting :default_enum_on, reader: true
      option :enum_on, default: ->{ self.class.default_enum_on }

      # Default query parameters
      setting :default_params, EMPTY_HASH, reader: true
      option :params, type: Types::Hash, default: ->{ self.class.default_params }

      # Request and response handlers
      config.default_response_handler = MashResponseHandler
      config.default_request_handler = RequestHandler

      # @override Handles multiple path segments and nils
      def with_path(segments)
        s = Array.wrap(segments)
        return self if s.empty?
        with_options(path: s.compact.join('/'))
      end

      def with_enum_on(keys)
        k = Array.wrap(keys)
        return self if k.empty?
        with_options(enum_on: k)
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

      def default_params(defaults = {})
        with_params defaults.merge(params)
      end

      # @override Seems good to have no-op when params not changed?
      def with_params(new_params)
        if params == new_params
          self
        else
          with_options(params: new_params)
        end
      end

      def param?(key)
        params.key?(key)
      end

      # Copies and makes private superclass #response method
      alias_method :__response__, :response
      private :__response__

      # @override Cache response by default
      def response
        cache.fetch_or_store(:response) { __response__ }
      end

      # @override
      def each(&block)
        return to_enum unless block_given?
        enumerable_response.each(&block)
      end

      def enumerable_response
        if options[:enum_on].nil?
          Array.wrap(response)
        else
          keys = Array.wrap options[:enum_on]
          Array.wrap response.dig(*keys)
        end
      end

      private

      def cache
        @cache ||= Concurrent::Map.new
      end

    end
  end
end
