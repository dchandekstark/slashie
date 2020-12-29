module ROM
  module Solr
    module Commands
      class UpdateDocuments < Update

        relation :documents

        register_as :update_documents

        def execute(tuples)
          relation.update_json_docs(tuples)
        end

      end
    end
  end
end
