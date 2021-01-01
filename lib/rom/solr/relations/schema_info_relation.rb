module ROM
  module Solr
    class SchemaInfoRelation < Relation

      schema(:schema_info) do
        # no-op
      end

      def show_defaults(show = true)
        add_params(showDefaults: Types::Bool[show])
      end

      def include_dynamic(enabled = true)
        add_params(includeDynamic: Types::Bool[enabled])
      end

      def info
        self
      end

      def copy_fields
        with_path :copyfields
      end

      def dynamic_fields
        with_path :dynamicfields
      end

      def dynamic_field(name)
        with_path "dynamicfields/#{name}"
      end

      def similarity
        with_path :similarity
      end

      def unique_key
        with_path :uniquekey
      end

      def version
        with_path :version
      end

      def schema_name
        with_path :name
      end

      def fields
        with_path :fields
      end

      def field(name)
        with_path "fields/#{name}"
      end

      def field_types
        with_path :fieldtypes
      end

      def field_type(name)
        with_path "fieldtypes/#{name}"
      end

    end
  end
end
