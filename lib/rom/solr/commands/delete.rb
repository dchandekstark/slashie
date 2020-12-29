module ROM
  module Solr
    module Commands
      class Delete < ROM::Commands::Delete

        adapter :solr

      end
    end
  end
end
