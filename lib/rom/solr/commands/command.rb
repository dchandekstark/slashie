module ROM
  module Solr
    module Commands
      class Command < ROM::Command
        adapter :solr
      end
    end
  end
end
