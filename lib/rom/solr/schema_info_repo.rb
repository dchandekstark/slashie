module ROM
  module Solr
    class SchemaInfoRepo < Repository[:schema_info]
      extend ResponseValue

      auto_struct false

      response_value :copy_fields,    key: :copyFields
      response_value :dynamic_fields, key: :dynamicFields
      response_value :fields
      response_value :field_types,    key: :fieldTypes
      response_value :similarity
      response_value :unique_key,     key: :uniqueKey
      response_value :version

      def info
        root.one[:schema]
      end

      def schema_name
        root.with_path(:name).one[:name]
      end

      def field_type(name)
        root.field_types(name).one[:fieldType]
      end

      def field(name)
        root.fields(name).show_defaults(true).one[:field]
      end

      def dynamic_field(name)
        root.dynamic_fields(name).one[:dynamicField]
      end

    end
  end
end
