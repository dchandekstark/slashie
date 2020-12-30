module ROM
  module Solr
    module Commands
      class CreateDocument < Create

        relation :json_update

        def execute(doc, commit: true, commit_within: nil)
          relation.add_document(doc, commit_within: commit_within).commit(commit)
        end

      end
    end
  end
end
