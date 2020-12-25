module ROM
  module Solr
    module Commands
      class Delete < ROM::HTTP::Commands::Delete
        adapter :solr

      end
    end
  end
end
