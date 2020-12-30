module ROM
  module Solr
    class DocumentsDataset < Dataset

      configure do |config|
        config.default_response_key = [:response, :docs]
        config.default_base_path    = 'select'
      end

      def num_found
        response.dig(:response, :numFound)
      end

      def cursor_mark
        params[:cursorMark]
      end

      def next_cursor_mark
        response[:nextCursorMark]
      end

      # @override
      # Delete by ID
      def delete
        json_update_command(:delete, map(&:id))
      end

      def delete_by_query(query)
        json_update_command(:delete, {query: query})
      end

      # @override
      def insert(docs)
        update_json_docs(docs)
      end

      # @override
      def update(docs)
        update_json_docs(docs)
      end

      def update_json_docs(docs)
        with_options(
          base_path: 'update/json/docs',
          content_type: 'application/json',
          params: {},
          request_data: JSON.dump(docs)
        )
      end

      def json_update_command(command, data)
        with_options(
          base_path: 'update',
          content_type: 'application/json',
          params: {},
          request_data: JSON.dump({command => data})
        ).response
      end

    end
  end
end
