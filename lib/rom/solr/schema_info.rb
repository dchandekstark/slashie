module ROM
  module Solr
    class SchemaInfo < ROM::Repository[:schema_info]
      extend ResponseValue

      response_value :copy_fields, key: :copyFields
      response_value :dynamic_fields, key: :dynamicFields
      response_value :fields
      response_value :field_types, key: :fieldTypes
      response_value :schema_name, key: :name
      response_value :similarity
      response_value :unique_key, key: :uniqueKey
      response_value :version

      def info
        root.one.schema
      end

      def field_type(name)
        root.field_types(name).one.fieldType
      end

      def field(name)
        root.fields(name).show_defaults(true).one.field
      end

      def dynamic_field(name)
        root.dynamic_fields(name).one.dynamicField
      end

    end
  end
end
