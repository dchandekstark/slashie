module Solrbee
  class Core

    attr_reader :name

    def initialize(name)
      @name = name
    end

    def schema
      Schema.get(name)
    end

  end
end
