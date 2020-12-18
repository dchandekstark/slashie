module ROM
  module Solr
    class Relation < ROM::HTTP::Relation
      extend Schemaless

      adapter :solr

      forward :add_param_values, :default_params, :with_enum_on

      def fetch(key, default = nil)
        return self if key.nil?
        dataset.response.fetch(key, default)
      end

      def count
        to_enum.count
      end

      def all
        self
      end

    end
  end
end
