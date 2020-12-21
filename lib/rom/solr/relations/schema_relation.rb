module ROM
  module Solr
    class SchemaInfoRelation < Relation
      schema(:schema, as: :schema_info) do
        # no schema
      end

      def version
        with_path(:version)
      end

      def schema_name
        with_path(:name)
      end

      def unique_key
        with_path(:unique_key)
      end
    end
  end
end
