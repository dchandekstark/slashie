module ROM
  module Solr
    class SchemaInfo < ROM::Repository[:schema_info]
      extend ResponseValue

      response_value :fields
      response_value :info, path: nil, key: :schema
      response_value :name
      response_value :similarity
      response_value :unique_key, path: :uniquekey, key: :uniqueKey
      response_value :version

      def field(name)
        root.field(name).one.field
      end

    end
  end
end
