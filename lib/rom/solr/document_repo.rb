module ROM
  module Solr
    class DocumentRepo < Repository[:documents]

      auto_struct false

      def find(id)
        documents.by_unique_key(id).one!
      end

      def all
        documents.all
      end

    end
  end
end
