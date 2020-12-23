require 'rom/solr/path_method'

module ROM
  module Solr
    class SchemaInfoRelation < Relation

      auto_struct false

      schema(:schema, as: :schema_info) { }

      query_param :showDefaults, :show_defaults,
                  type: Types::Bool.default(true)

      query_param :includeDynamic, :include_dynamic,
                  type: Types::Bool.default(true)

      path_method :copyfields,    as: :copy_fields
      path_method :dynamicfields, as: :dynamic_fields
      path_method :similarity
      path_method :uniquekey,     as: :unique_key
      path_method :version

      def schema_name
        with_path(:name)
      end

      def fields(name = nil)
        path = "fields"
        path += "/#{name}" if name
        with_path(path)
      end

      def dynamic_fields(name = nil)
        path = "dynamicfields"
        path += "/#{name}" if name
        with_path(path)
      end

      def field_types(name = nil)
        path = "fieldtypes"
        path += "/#{name}" if name
        with_path(path)
      end

    end
  end
end
