module ROM
  module Solr
    class DocumentsDataset < Dataset

      configure do |config|
        config.default_base_path = 'select'
      end

      # @override
      def each(&block)
        return to_enum unless block_given?

        docs.each(&block)
      end

      def docs
        search_response(:docs)
      end

      def cursor_mark
        params[:cursorMark]
      end

      def next_cursor_mark
        response[:nextCursorMark]
      end

      def num_found
        search_response(:numFound)
      end

      def num_found_exact
        search_response(:numFoundExact)
      end

      def num_found_exact?
        num_found_exact === true
      end

      def search_response(key)
        response.dig(:response, key)
      end

      def partial_results
        response_header(:partialResults)
      end

      def partial_results?
        partial_results === true
      end

      def response_params
        response_header(:params)
      end

      def response_params?
        !response_params.nil? && !response_params.empty?
      end

    end
  end
end
