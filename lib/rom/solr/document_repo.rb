module ROM
  module Solr
    class DocumentRepo < Repository[:documents]

      auto_struct false

      def find(id)
        documents.by_unique_key(id).one!
      end

      def search
        documents
      end

      def all
        documents.all
      end

      def create(docs)
        documents.command(:create_documents).call(docs)
      end

      def delete(docs)
        documents.command(:delete_documents).call(docs)
      end

      def update(docs)
        documents.command(:update_documents).call(docs)
      end

    end
  end
end
