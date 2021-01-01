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
        response.dig(:response, :docs)
      end

      def cursor_mark
        params[:cursorMark]
      end

      def next_cursor_mark
        response[:nextCursorMark]
      end

      def num_found
        response.dig(:response, :numFound)
      end

      def num_found_exact
        response.dig(:response, :numFoundExact)
      end

    end
  end
end
