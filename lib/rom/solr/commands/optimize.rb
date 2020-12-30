module ROM
  module Solr
    module Commands
      class Optimize < Command
        relation :documents

        # options:
        #
        # waitSearcher (def. true)
        # maxSegments
        #
        def execute(options = {})
          relation.json_update_command(optimize: options)
        end
      end
    end
  end
end
