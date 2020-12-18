module ROM
  module Solr
    class SchemaRelation < Relation

      schemaless(:schema, as: :schema_info)

      # GET /schema
      def info
        fetch('schema')
      end

      def schema_name
        with_path(:name).fetch(:name)
      end

      def version
        with_path('version').fetch('version')
      end

      def unique_key
        with_path('uniquekey').fetch('uniqueKey')
      end

      def similarity
        with_path('similarity').fetch('similarity')
      end

      # @param opts [Hash]
      def fields(**opts)
        default_opts = { showDefaults: true }
        with_path('fields')
          .with_enum_on('fields')
          .add_params(default_opts.merge(opts))
      end

      # @param name [String, Symbol] field name
      # @param opts [Hash]
      def field(name, **opts)
        with_path('fields', name)
          .add_params(opts)
          .fetch('field')
      end

      # @param opts [Hash]
      def field_types(**opts)
        with_path('fieldtypes')
          .with_enum_on('fieldTypes')
          .add_params(opts)
      end

      # @param name [String, Symbol] field type name
      # @param opts [Hash]
      def field_type(name, **opts)
        with_path('fieldtypes', name).add_params(opts).fetch('fieldType')
      end

      # @param opts [Hash]
      def dynamic_fields(**opts)
        with_path('dynamicfields').with_enum_on('dynamicFields').add_params(opts)
      end

      # @param name [String, Symbol] dynamic field name
      # @param opts [Hash]
      def dynamic_field(name, **opts)
        with_path('dynamicfields', name).add_params(opts).fetch('dynamicField')
      end

      # @param opts [Hash]
      def copy_fields(**opts)
        with_path('copyfields').with_enum_on('copyFields').add_params(opts)
      end

    end
  end
end
