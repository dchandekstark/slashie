module ROM
  module Solr
    class UpdateDataset < Dataset

      option :request_data

      configure do |config|
        config.default_request_handler = UpdateRequestHandler
      end

      def update(doc)
        with_data(doc).add_params('json.command'=>false)
      end

      def update_many(docs)
        with_data(docs).with_path("json/docs")
      end

      def with_data(data)
        with_options(request_data: data, request_method: :post)
          .add_header('Content-Type', 'application/json')
      end

    end
  end
end
