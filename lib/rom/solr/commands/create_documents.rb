module ROM
  module Solr
    module Commands
      class CreateDocuments < Create

        relation :documents

        def execute(docs, **options)
          relation.insert(docs, **options).response
        end

      end
    end
  end
end
