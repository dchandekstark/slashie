module ROM
  module Solr
    module Commands
      class CreateDocuments < Create
        relation :documents

        def execute(docs, commit: true)
          relation.update_json_docs(docs)
        end
      end
    end
  end
end
