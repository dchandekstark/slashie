module ROM
  module Solr
    class Dataset < ROM::HTTP::Dataset

      configure do |config|
        config.default_response_handler = Response
        config.default_request_handler = Request
      end

      def remove_params(*keys)
        keep = params.keys - keys
        with_params params.slice(*keep)
      end

      # Coerce param value to an Array and set new value
      # to set union with other Array of values.
      def add_values(key, val)
        params[key] = Array(params[key]) | Array(val)
      end

      # @override
      # Not using the superclass implementation b/c wary of deep merge.
      # (Why is it used for query params?)
      def add_params(new_params)
        with_params params.merge(new_params)
      end

      def default_params(defaults)
        merged = defaults.merge(params)
        if merged == params
          self
        else
          with_params(merged)
        end
      end

      def param?(key)
        params.key?(key)
      end

      # @override
      def response
        cache.load(:response) { super }
      end

      private

      def cache
        @cache ||= Cache.new
      end

      class Cache
        attr_reader :backend

        def initialize
          @backend = {}
        end

        def get(key)
          backend[key]
        end

        def set(key, val)
          backend[key] = val
        end

        def load(key, &block)
          get(key) || set(key, block.call)
        end

        def flush
          backend.clear
        end
      end
    end
  end
end
