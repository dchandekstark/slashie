module ROM
  module Solr
    module Commands
      class Update < ROM::Commands::Update
        adapter :solr
      end
    end
  end
end
