module ROM
  module Solr
    module Commands
      class CreateDocuments < Create

        relation :documents

        def execute(docs)
          relation.insert(docs).response
        end

      end
    end
  end
end
