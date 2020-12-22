module ROM
  module Solr
    class SelectDataset < Dataset

      # @override
      def each(&block)
        return to_enum unless block_given?
        docs.each(&block)
      end

      def docs
        response[0].dig('response', 'docs')
      end

      def num_found
        response[0].dig('response', 'numFound')
      end

      def cursor_mark
        params[:cursorMark]
      end

      def next_cursor_mark
        response[0]['nextCursorMark']
      end

    end
  end
end
