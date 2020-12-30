module ROM
  module Solr
    module Commands
      class CreateDocuments < Create

        relation :json_update

        def execute(docs, commit: true, commit_within: nil)

        end

      end
    end
  end
end
