module ROM
  module Solr
    module Commands
      class Update < ROM::HTTP::Commands::Update
        adapter :solr

      end
    end
  end
end
