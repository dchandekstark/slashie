module ROM
  module Solr
    #
    # Solr service gateway
    #
    class Gateway < ROM::HTTP::Gateway
      adapter :solr

      def initialize(config = {})
        config[:uri]     ||= ENV.fetch('SOLR_URL', 'http://localhost:8983/solr')
        config[:headers] ||= { Accept: 'application/json' }
        super
      end

    end

  end
end
