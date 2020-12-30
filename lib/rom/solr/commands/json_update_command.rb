module ROM
  module Solr
    module Commands
      module JSONUpdateCommand

        def json_update_command(data)
          relation.with_options(
            base_path: 'update',
            request_data: JSON.dump(data),
            content_type: 'application/json'
          )
        end

      end
    end
  end
end
