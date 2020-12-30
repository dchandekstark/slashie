module ROM
  module Solr
    class SchemaInfoRepo < Repository[:schema_info]

      auto_struct false

      %i[ schema_name similarity unique_key version ].each do |name|
        define_method name, ->{ schema_info.send(name).one! }
      end

      def info
        schema_info.info.one!
      end

      def fields(dynamic: true, defaults: true)
        schema_info.fields.show_defaults(defaults).include_dynamic(dynamic)
      end

      def field(name, defaults: true)
        schema_info.field(name).show_defaults(defaults).one
      end

      def field_types(defaults: true)
        schema_info.field_types.show_defaults(defaults)
      end

      def field_type(name, defaults: true)
        schema_info.field_type(name).show_defaults(defaults).one
      end

      def dynamic_fields
        schema_info.dynamic_fields
      end

      def dynamic_field(name, defaults: true)
        schema_info.dynamic_field(name).show_defaults(defaults).one
      end

      def copy_fields
        schema_info.copy_fields
      end

    end
  end
end
