module ROM
  module Solr
    class SchemaInfoRepo < Repository[:schema_info]

      auto_struct false

      %i[ schema_name similarity unique_key version ].each do |name|
        define_method name, ->{ root.send(name).one! }
      end

      def info
        root.info.one!
      end

      def fields(dynamic: true, defaults: true)
        root.fields.show_defaults(defaults).include_dynamic(dynamic)
      end

      def field(name, defaults: true)
        root.field(name).show_defaults(defaults).one
      end

      def field_types(defaults: true)
        root.field_types.show_defaults(defaults)
      end

      def field_type(name, defaults: true)
        root.field_type(name).show_defaults(defaults).one
      end

      def dynamic_fields
        root.dynamic_fields
      end

      def dynamic_field(name, defaults: true)
        root.dynamic_field(name).show_defaults(defaults).one
      end

      def copy_fields
        root.copy_fields
      end

    end
  end
end
