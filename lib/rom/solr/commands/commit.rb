module ROM
  module Solr
    module Commands
      class Commit < Command
        relation :documents

        # options:
        #
        # waitSearcher (def. true)
        # expungeDeletes (def. false)
        #
        def execute(options = {})
          relation.json_update_command(commit: options)
        end
      end
    end
  end
end
