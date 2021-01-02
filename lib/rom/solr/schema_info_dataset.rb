module ROM
  module Solr
    class SchemaInfoDataset < Dataset

      configure do |config|
        config.default_base_path = 'schema'

        config.default_response_handler = Proc.new do |*args|
          ResponseHandler.call(*args).values.flatten
        end

        config.default_request_handler = Proc.new do |dataset|
          RequestHandler.call(dataset.add_params(omitHeader: true))
        end
      end

    end
  end
end
