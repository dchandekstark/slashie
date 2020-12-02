module Solrbee
  class Collection

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def to_s
      name
    end

    def schema
      @schema ||= SchemaApi.new(self)
    end

  end
end
