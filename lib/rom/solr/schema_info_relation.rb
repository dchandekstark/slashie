module ROM
  module Solr
    class SchemaInfoRelation < Relation

      auto_struct false

      schema(:schema, as: :schema_info) do
        # no schema
      end

      query_param :show_defaults,
                  param: :showDefaults,
                  type: Types::Bool.default(true)

      query_param :include_dynamic,
                  param: :includeDynamic,
                  type: Types::Bool.default(true)

      def copy_fields;    with_path(:copyfields);    end
      def schema_name;    with_path(:name);          end
      def similarity;     with_path(:similarity);    end
      def unique_key;     with_path(:uniquekey);     end
      def version;        with_path(:version);       end

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
