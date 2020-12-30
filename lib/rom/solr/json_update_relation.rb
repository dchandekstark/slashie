module ROM
  module Solr
    class JSONUpdateRelation < Relation

      schema(:update) { }

      def delete_by_id(id, version: nil)
        data = { id: id, :_version_: version }.compact

        delete(data)
      end

      def delete_document(doc, version: nil)
        delete_by_id(doc.fetch(:id), version: version)
      end

      def delete_ids(ids)
        delete(Array.wrap(ids))
      end

      def delete_documents(docs)
        ids = docs.map(&:id).compact

        delete_ids(ids)
      end

      def delete_by_query(query)
        delete(query: query)
      end

      def delete(data)
        add_commands(delete: data)
      end

      def add(doc, overwrite: nil, commit_within: nil)
        data = { doc: doc, overwrite: overwrite, commitWithin: commit_within }.compact

        add_commands(add: data)
      end

      def commit(wait_searcher: nil, expunge_deletes: nil)
        data = { waitSearcher: wait_searcher, expungeDeletes: expunge_deletes }.compact

        add_commands(commit: data)
      end

      def optimize(wait_searcher: nil, max_segments: nil)
        data = { waitSearcher: wait_searcher, maxSegments: max_segements }.compact

        add_commands(optimize: data)
      end

      def add_commands(new_commands)
        # TODO
      end

    end
  end
end
