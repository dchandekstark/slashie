module ROM
  module Solr
    class SchemaRelation < Relation
      schema(:schema) do
        attribute :name,       Types::String
        attribute :version,    Types::Float
        attribute :uniqueKey,  Types::String
        attribute :fieldTypes, Types::Array
        attribute :fields,     Types::Array
        attribute :copyFields, Types::Array
      end
    end
  end
end
