module ROM
  module Solr
    module Commands
      class DeleteDocuments < Delete

        relation :documents

        register_as :delete_documents

        def execute
          data = { delete: relation.map(&:id) }

          relation.update_json_docs(data)
        end

      end
    end
  end
end
