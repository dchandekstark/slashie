module Solrbee
  class Response < Base

    coerce_key :schema, Schema
    coerce_key :fields, Array[Schema::Field]
    coerce_key :field, Schema::Field

  end
end
