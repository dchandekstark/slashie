require 'rom/solr/query_builder'

module ROM
  module Solr
    class DocumentRepo < Repository[:documents]

      auto_struct false

      def find(id)
        documents.by_unique_key(id).one!
      end

      def query(&block)
        documents.query(&block)
      end

      def filter(&block)
        documents.filter(&block)
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

      private

      def docs_command(command, data, **opts)
        documents.command(command).call(data, **opts)
      end

    end
  end
end
