module ROM
  module Solr
    module Commands
      class UpdateDocuments < Update

        relation :documents

        def execute(docs)
          relation.update(docs)
        end

      end
    end
  end
end
