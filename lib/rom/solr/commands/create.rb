module ROM
  module Solr
    module Commands
      class Create < ROM::Commands::Create
        adapter :solr
      end
    end
  end
end
