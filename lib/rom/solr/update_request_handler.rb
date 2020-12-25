module ROM
  module Solr
    class UpdateRequestHandler

      def self.call(dataset)
        RequestHandler.call(dataset) do |request|
          request.body = JSON.dump(dataset.request_data)
        end
      end

    end
  end
end
