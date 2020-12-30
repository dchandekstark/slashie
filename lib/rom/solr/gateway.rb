module ROM
  module Solr
    class Gateway < ROM::HTTP::Gateway

      adapter :solr

      # @override
      def dataset(name)
        ROM::Solr.dataset_class(name).new(config)
      end

    end
  end
end
