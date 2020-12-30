module ROM
  module Solr
    class JsonUpdateRelation < Relation

      schema(:update, as: :json_update) { }

      def each(&block)
        return to_enum unless block_given?

        dump_commands

        super
      end

      def delete_by_id(id, version: nil)
        data = { id: id, _version_: version }.compact

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

      def add_document(doc, overwrite: nil, commit_within: nil)
        data = { doc: doc, overwrite: overwrite, commitWithin: commit_within }.compact

        add_commands(add: data)
      end

      def commit(value = true, wait_searcher: nil, expunge_deletes: nil)
        return self unless value

        data = { waitSearcher: wait_searcher, expungeDeletes: expunge_deletes }.compact

        add_commands(commit: data)
      end

      def commit_within(millis)
        add_params(commitWithin: Types::Coercible::Integer[millis])
      end

      def overwrite(value = true)
        add_params(overwrite: Types::Bool[value])
      end

      def optimize(wait_searcher: nil, max_segments: nil)
        data = { waitSearcher: wait_searcher, maxSegments: max_segements }.compact

        add_commands(optimize: data)
      end

      private

      def add_commands(new_commands)
        with_options(commands: commands + new_commands.to_a)
      end

      def dump_commands
        cmd_json = commands.map { |cmd| cmd.map { |c| JSON.dump(c) }.join(':') }.join(',')

        self.request_data = '{%s}' % cmd_json
      end

    end
  end
end
