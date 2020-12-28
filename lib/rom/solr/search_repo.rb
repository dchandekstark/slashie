module ROM
  module Solr
    class SearchRepo < Repository[:search]

      auto_struct false

      def find(id)
        root.by_unique_key(id).one!
      end

    end
  end
end
