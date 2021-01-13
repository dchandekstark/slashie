require 'forwardable'

module ROM
  module Solr
    class SchemaInfoRepo < Repository[:schema_info]
      extend Forwardable

      auto_struct false

      VALUES = %i[ schema_name
                   similarity
                   unique_key
                   version
                   info
                   field
                   field_type
                   dynamic_field
                   copy_field
                   ]

      def_delegators :schema_info, :fields, :field_types, :dynamic_fields, :copy_fields

      VALUES.each do |name|
        define_method name, proc { |*args| schema_info.send(name, *args).one! }
      end

      def field_map(**opts)
        fields(**opts).each_with_object({}) do |field, memo|
          key = field.delete(:name)
          memo[key] = field
        end
      end

    end
  end
end
