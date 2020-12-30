module ROM
  module Solr
    module Commands
      class DeleteDocumentsByQuery < Delete

        relation :documents

        def execute(query)
          relation.delete_by_query(query).response
        end

      end
    end
  end
end
