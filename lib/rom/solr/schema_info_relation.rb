module ROM
  module Solr
    class SchemaInfoRelation < Relation

      auto_struct false

      schema(:schema, as: :schema_info) { }

      def show_defaults(show = true)
        add_params(showDefaults: Types::Bool[show])
      end

      def include_dynamic(enabled = true)
        add_params(includeDynamic: Types::Bool[enabled])
      end

      def info
        with_data_path(:schema)
      end

      def copy_fields
        with_options(path: :copyfields, data_path: :copyFields)
      end

      def dynamic_fields
        with_options(path: :dynamicfields, data_path: :dynamicFields)
      end

      def dynamic_field(name)
        with_options(path: "dynamicfields/#{name}", data_path: :dynamicField)
      end

      def similarity
        with_options(path: :similarity, data_path: :similarity)
      end

      def unique_key
        with_options(path: :uniquekey, data_path: :uniqueKey)
      end

      def version
        with_options(path: :version, data_path: :version)
      end

      def schema_name
        with_options(path: :name, data_path: :name)
      end

      def fields
        with_options(path: :fields, data_path: :fields)
      end

      def field(name)
        with_options(path: "fields/#{name}", data_path: :field)
      end

      def field_types
        with_options(path: :fieldtypes, data_path: :fieldTypes)
      end

      def field_type(name)
        with_options(path: "fieldtypes/#{name}", data_path: :fieldType)
      end

    end
  end
end
