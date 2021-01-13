module ROM
  module Solr
    class SchemaInfoRelation < Relation

      schema(:schema_info) do
        # no-op
      end

      dataset do
        with_options(
          base_path: 'schema',
          params: { omitHeader: true },
          response_handler: ->(*args) { ResponseHandler.call(*args).values.flatten }
        )
      end

      def show_defaults(show = true)
        add_params(showDefaults: Types::Bool[show])
      end

      def include_dynamic(enabled = true)
        add_params(includeDynamic: Types::Bool[enabled])
      end

      def info
        self
      end

      def copy_fields(source_fields: nil, dest_fields: nil)
        source_fl = Array.wrap(source_fields).join(',') unless source_fields.nil?
        dest_fl   = Array.wrap(dest_fields).join(',') unless dest_fields.nil?

        with_path(:copyfields)
          .add_params('source.fl'=>source_fl, 'dest.fl'=>dest_fl)
      end

      def dynamic_fields(defaults: true)
        with_path(:dynamicfields)
          .show_defaults(defaults)
      end

      def dynamic_field(name, defaults: true)
        with_path("dynamicfields/#{name}")
          .show_defaults(defaults)
      end

      def similarity
        with_path :similarity
      end

      def unique_key
        with_path :uniquekey
      end

      def version
        with_path :version
      end

      def schema_name
        with_path :name
      end

      def fields(dynamic: true, defaults: true)
        with_path(:fields)
          .include_dynamic(dynamic)
          .show_defaults(defaults)
      end

      def field(name, defaults: true)
        with_path("fields/#{name}")
          .show_defaults(defaults)
      end

      def field_types(defaults: true)
        with_path(:fieldtypes)
          .show_defaults(defaults)
      end

      def field_type(name, defaults: true)
        with_path("fieldtypes/#{name}")
          .show_defaults(defaults)
      end

    end
  end
end
