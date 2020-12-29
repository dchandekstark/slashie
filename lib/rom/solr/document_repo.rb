module ROM
  module Solr
    class DocumentRepo < Repository[:documents]

      auto_struct false

      def find(id)
        root.by_unique_key(id).one!
      end

    end
  end
end
