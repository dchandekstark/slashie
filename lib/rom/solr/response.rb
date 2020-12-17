module ROM
  module Solr
    class Response

      def self.call(response, dataset)
        JSON.parse(response.body)
      end

    end
  end
end
