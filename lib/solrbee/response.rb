module Solrbee
  class Response < Base

    coerce_key :schema,         Schema
    coerce_key :fields,         Array[Field]
    coerce_key :field,          Field
    coerce_key :responseHeader, Header
    coerce_key :fieldTypes,     Array[FieldType]
    coerce_key :fieldType,      FieldType

    def self.handle(http_response)
      http_response.value # raises Net::HTTPServerException
      parsed = JSON.parse(http_response.body, symbolize_names: true, object_class: Solrbee::Base)
      new(parsed)
    end

    def status
      responseHeader.status
    end

  end
end
