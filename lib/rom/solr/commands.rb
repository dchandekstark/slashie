module ROM
  module Solr
    module Commands
      class Create < ROM::Commands::Create
        adapter :solr
      end

      class Update < ROM::Commands::Update
        adapter :solr
      end

      class Delete < ROM::Commands::Delete
        adapter :solr
      end
    end
  end
end
