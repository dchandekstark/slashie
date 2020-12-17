require 'rom/solr/paginated_dataset'
require 'rom/solr/cache'

module ROM
  module Solr
    class DocumentDataset < Dataset
      params {q: '*:*'}
    end
  end
end
