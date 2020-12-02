module Solrbee
  class Collection

    attr_reader :name

    def initialize(name)
      @name = name
    end

    %i[ schema fields unique_key ].each do |api|
      define_method api do
        SchemaApi.send(api, name)
      end
    end

    def field(field_name)
      SchemaApi.field(name, field_name)
    end

  end
end
