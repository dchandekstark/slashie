module Solrbee
  class Cache

    attr_reader :backend

    def initialize
      @backend = {}
    end

    def get(key)
      backend[key]
    end

    def set(key, val)
      backend[key] = val
    end

    def load(key, &block)
      get(key) || set(key, block.call)
    end

    def flush
      backend.clear
    end

  end
end
