module ROM
  module Solr
    class SchemaInfoRelation < Relation

      auto_struct false

      schema(:schema, as: :schema_info) do
        # no schema
      end

      query_param :show_defaults, param: :showDefaults, default: true
      query_param :include_dynamic, param: :includeDynamic, default: true

      def field(name)
        with_path("fields/#{name}")
      end

      path_method :field_types, path: :fieldtypes
      path_method :copy_fields, path: :copyfields
      path_method :dynamic_fields, path: :dynamicfields

    end
  end
end
