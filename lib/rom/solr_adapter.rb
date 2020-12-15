module ROM
  module SolrAdapter

    class Gateway < ROM::HTTP::Gateway
      def initialize(uri: nil)
        super(uri: uri || Solrbee.solr_url,
              headers: {'Accept'=>'application/json'})
      end
    end

    class Dataset < ROM::HTTP::Dataset
    end

    class Relation < ROM::HTTP::Relation
    end

  end
end
