module ROM
  module Solr
    module Commands
      class DeleteDocuments < Delete

        relation :documents

        def execute
          relation.delete
        end

      end
    end
  end
end
