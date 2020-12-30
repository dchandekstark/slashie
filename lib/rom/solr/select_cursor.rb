require 'delegate'

module ROM
  module Solr
    #
    # Wraps a DocumentsRelation to provide pagination with a cursor.
    #
    class SelectCursor < SimpleDelegator

      def initialize(relation)
        params = { cursorMark: '*' }

        # Sort must include a sort on unique key (id).
        sort = relation.dataset.params[:sort]
        unless /\bid\b/ =~ sort
          params[:sort] = Array.wrap(sort).append('id ASC').join(',')
        end

        super relation.add_params(params)
      end

      def each(&block)
        return to_enum unless block_given?

        while true
          __getobj__.each(&block)

          break if last_page?

          move_cursor
        end
      end

      def last_page?
        cursor_mark == next_cursor_mark
      end

      def cursor_mark
        dataset.params[:cursorMark]
      end

      def next_cursor_mark
        dataset.response[:nextCursorMark]
      end

      def move_cursor
        __setobj__(next_page)
      end

      def next_page
        __getobj__.add_params(cursorMark: next_cursor_mark)
      end

    end
  end
end
