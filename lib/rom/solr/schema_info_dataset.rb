module ROM
  module Solr
    class SchemaInfoDataset < Dataset

      configure do |config|
        config.default_base_path = 'schema'
        config.default_params    = { omitHeader: true }

        config.default_response_handler =
          proc { |*args| ResponseHandler.call(*args).values.flatten }
      end

    end
  end
end
