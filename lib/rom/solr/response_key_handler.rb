module ROM
  module Solr
    class ResponseKeyHandler

      # @param key [Symbol] key for the value to return from the parsed response
      # @return [Proc]
      def self.[](key)
        Proc.new do |response, dataset|
          content = ResponseHandler.call(response, dataset)
          Array.wrap(content[key])
        end
      end

    end
  end
end
