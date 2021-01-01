module ROM
  module Solr
    module Commands
      class DeleteDocuments < Delete

        relation :documents

        def execute(docs)
          relation.delete(docs).response
        end

      end
    end
  end
end
