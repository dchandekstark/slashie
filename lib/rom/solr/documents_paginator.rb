require 'delegate'

module ROM
  module Solr
    #
    # Wraps a DocumentsDataset to provide pagination with a cursor.
    #
    class DocumentsPaginator < SimpleDelegator

      def each(&block)
        while true
          super
          break if cursor_mark == next_cursor_mark
          next_page = __getobj__.add_params(cursorMark: next_cursor_mark)
          __setobj__(next_page)
        end
      end

    end
  end
end
