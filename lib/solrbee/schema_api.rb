module Solrbee
  module SchemaApi

    def self.schema(collection)
      response = Solrbee.get('%s/schema' % collection)
      response.schema
    end

    def self.fields(collection)
      response = Solrbee.get('%s/schema/fields' % collection)
      response.fields
    end

    def self.field(collection, field_name)
      response = Solrbee.get('%s/schema/fields/%s' % [collection, field_name])
      response.field
    end

    def self.unique_key(collection)
      response = Solrbee.get('%s/schema/uniquekey' % collection)
      response.uniqueKey
    end

  end
end
