module ROM
  module Solr
    class SelectDataset < Dataset

      option :params, type: Types::Hash, default: proc { {q: '*:*'} }

      def num_found
        response['response']['numFound']
      end

      def docs
        response['response']['docs']
      end

    end
  end
end
