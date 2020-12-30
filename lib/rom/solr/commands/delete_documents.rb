module ROM
  module Solr
    module Commands
      class DeleteDocuments < Delete
        relation :documents
      end

      class DeleteDocumentsById < DeleteDocuments
        def execute(*)
          relation.json_update_command(delete: relation.map(&:id))
        end
      end

      class DeleteDocumentsByQuery < DeleteDocuments
        def execute(*)
          query = relation.dataset.params.fetch(:q)

          relation.json_update_command(delete: {query: query})
        end
      end
    end
  end
end
