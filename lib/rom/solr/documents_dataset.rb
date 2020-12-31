module ROM
  module Solr
    class DocumentsDataset < Dataset

      configure do |config|
        config.default_response_key = [:response, :docs]
        config.default_base_path    = 'select'
      end

    end
  end
end
