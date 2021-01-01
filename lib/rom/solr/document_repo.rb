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

      def create(docs, **opts)
        docs_command(:create_documents, docs, **opts)
      end

      def delete(docs, **opts)
        docs_command(:delete_documents, docs, **opts)
      end

      def delete_by_query(query, **opts)
        docs_command(:delete_documents_by_query, query, **opts)
      end

      def update(docs, **opts)
        docs_command(:update_documents, docs, **opts)
      end

      def docs_command(command, data, commit: false, commit_within: nil)
        documents
          .commit(commit)
          .commit_within(commit_within)
          .command(command)
          .call(data)
      end

    end
  end
end
