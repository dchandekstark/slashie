module ROM
  module Solr
    class ResponseHandler

      # @param response [Net::HTTPResponse] the original HTTP response
      # @param dataset [Dataset] the dataset
      # @return [Hash] Parsed JSON object from Solr response body
      # @raise [Error] a parser or HTTP error
      def self.call(response, dataset)
        Solrbee.logger.debug { "#{self}: #{response.inspect}" }
        response.value
        parse(response)
      rescue Net::HTTPServerException => e
        err_msg = parse(response).dig(:error, :msg) rescue nil
        err_msg ||= e.full_message
        err_type = response.is_a?(Net::HTTPNotFound) ? NotFoundError : Error
        raise err_type, err_msg
      end

      def self.parse(response)
        JSON.parse(response.body, symbolize_names: true)
      rescue JSON::ParserError => e
        raise Error, "Unable to parse response content as JSON: %s" % e
      end

    end
  end
end
