require 'rom/solr/modify_schema'

module ROM
  module Solr
    class SchemaInfoRelation < Relation

      schema(:schema_info) do
        # no-op
      end

      dataset do
        with_base_path(:schema)
      end

      ModifySchema::INSERT.each do |op|
        meth = op.gsub(/-/, '_').to_sym

        define_method meth, ->(spec) { insert(op, spec) }
      end

      ModifySchema::UPDATE.each do |op|
        meth = op.gsub(/-/, '_').to_sym

        define_method meth, ->(spec) { update(op, spec) }
      end

      ModifySchema::DELETE.each do |op|
        meth = op.gsub(/-/, '_').to_sym

        body = case op
               when 'delete-copy-field'
                 ->(source, dest) { delete(op, source: source, dest: dest) }
               else
                 ->(name) { delete(op, name: name) }
               end

        define_method meth, body
      end

      def info
        with_response_key(:schema)
      end

      def copy_fields(source_fields: nil, dest_fields: nil)
        source_fl = Array.wrap(source_fields).join(',') unless source_fields.nil?
        dest_fl   = Array.wrap(dest_fields).join(',') unless dest_fields.nil?

        with_path(:copyfields)
          .with_response_key(:copyFields)
          .add_params('source.fl'=>source_fl, 'dest.fl'=>dest_fl)
      end

      def dynamic_fields(defaults: true)
        with_path(:dynamicfields)
          .with_response_key(:dynamicFields)
          .show_defaults(defaults)
      end

      def dynamic_field(name, defaults: true)
        with_path("dynamicfields/#{name}")
          .with_response_key(:dynamicField)
          .show_defaults(defaults)
      end

      def similarity
        with_path(:similarity)
          .with_response_key(:similarity)
      end

      def unique_key
        with_path(:uniquekey)
          .with_response_key(:uniqueKey)
      end

      def version
        with_path(:version)
          .with_response_key(:version)
      end

      def schema_name
        with_path(:name)
          .with_response_key(:name)
      end

      def fields(dynamic: true, defaults: true)
        with_path(:fields)
          .with_response_key(:fields)
          .include_dynamic(dynamic)
          .show_defaults(defaults)
      end

      def field(name, defaults: true)
        with_path("fields/#{name}")
          .with_response_key(:field)
          .show_defaults(defaults)
      end

      def field_types(defaults: true)
        with_path(:fieldtypes)
          .with_response_key(:fieldTypes)
          .show_defaults(defaults)
      end

      def field_type(name, defaults: true)
        with_path("fieldtypes/#{name}")
          .with_response_key(:fieldType)
          .show_defaults(defaults)
      end

      #
      # Parameters
      #

      def show_defaults(show = true)
        add_params(showDefaults: Types::Bool[show])
      end

      def include_dynamic(enabled = true)
        add_params(includeDynamic: Types::Bool[enabled])
      end

      private

      def insert(op, spec)
        modify_schema(op=>spec)
      end

      def update(op, spec)
        modify_schema(op=>spec)
      end

      def delete(op, spec)
        modify_schema(op=>spec)
      end

      def modify_schema(data)
        with_options(
          request_method: :post,
          content_type: 'application/json',
          request_data: JSON.dump(data)
        )
      end

    end
  end
end
