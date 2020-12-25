module ROM
  module Solr
    module Commands
      class Create < ROM::HTTP::Commands::Create
        adapter :solr

      end
    end
  end
end
