module ROM
  module Solr
    module Commands
      class CreateDocuments < Create

        relation :documents

        register_as :create_documents

        def execute(tuples)
          relation.update_json_docs(tuples)
        end

      end
    end
  end
end
