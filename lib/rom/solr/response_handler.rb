module ROM
  module Solr
    class ResponseHandler

      # @return [Hash] Parsed JSON object from Solr response body
      def self.call(response, dataset)
        Array.wrap JSON.parse(response.body, symbolize_names: true)
      end

    end
  end
end
