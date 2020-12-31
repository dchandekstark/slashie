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
        with_response_key(:schema)
      end

      def copy_fields
        with_options(
          path: :copyfields,
          response_key: :copyFields
        )
      end

      def dynamic_fields
        with_options(
          path: :dynamicfields,
          response_key: :dynamicFields
        )
      end

      def dynamic_field(name)
        with_options(
          path: "dynamicfields/#{name}",
          response_key: :dynamicField
        )
      end

      def similarity
        with_options(
          path: :similarity,
          response_key: :similarity
        )
      end

      def unique_key
        with_options(
          path: :uniquekey,
          response_key: :uniqueKey
        )
      end

      def version
        with_options(
          path: :version,
          response_key: :version
        )
      end

      def schema_name
        with_options(
          path: :name,
          response_key: :name
        )
      end

      def fields
        with_options(
          path: :fields,
          response_key: :fields
        )
      end

      def field(name)
        with_options(
          path: "fields/#{name}",
          response_key: :field
        )
      end

      def field_types
        with_options(
          path: :fieldtypes,
          response_key: :fieldTypes
        )
      end

      def field_type(name)
        with_options(
          path: "fieldtypes/#{name}",
          response_key: :fieldType
        )
      end

    end
  end
end
