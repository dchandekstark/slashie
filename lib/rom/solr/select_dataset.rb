module ROM
  module Solr
    class SelectDataset < Dataset

      configure do |config|
        config.default_response_key = [:response, :docs]
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

    end
  end
end
