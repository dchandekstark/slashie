module ROM
  module Solr
    class ResponseHandler

      # @return [Hash] Parsed JSON object from Solr response body
      def self.call(response, dataset)
        Solrbee.logger.debug { "#{self}: #{response.inspect}" }

        JSON.parse(response.body, symbolize_names: true)
      end

    end
  end
end
