module ROM
  module Solr
    class SelectDataset < Dataset

      config.default_enum_on = [ 'response', 'docs' ]
      config.default_params  = { q: '*:*', start: 0, rows: 20, cursorMark: '*', sort: 'id ASC' }

      # @override
      def each
        while true
          enumerable_response.each { |doc| yield(doc) }
          break if last_page?
          update_cursor_mark
        end
      end

      def num_found
        response.dig('response', 'numFound')
      end

      def cursor_mark
        params[:cursorMark]
      end

      def next_cursor_mark
        response['nextCursorMark']
      end

      def page_size
        params[:rows]
      end

      def last_cursor?
        cursor_mark == next_cursor_mark
      end

      def one_page?
        num_found <= page_size
      end

      def last_page?
        one_page? || last_cursor?
      end

      private

      def update_cursor_mark
        add_params(cursorMark: next_cursor_mark)
      end

    end
  end
end
