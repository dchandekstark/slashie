require 'forwardable'
require 'rom/solr/documents_paginator'

module ROM
  module Solr
    class DocumentsRelation < Relation

      def_delegators :dataset, :num_found, :num_found_exact

      schema(:documents) { }

      # @override
      def each(&block)
        return super unless cursor?

        return to_enum unless block_given?

        DocumentsPaginator.new(dataset).each(&block)
      end

      # @override FIXME: Get from Solr schema unique key
      def primary_key
        :id
      end

      def by_unique_key(id)
        q('%s:%s' % [ primary_key, id ])
      end

      def all
        q('*:*')
      end

      # @override
      def count
        num_found_exact ? num_found : super
      end

      # Set a cursor on the relation for pagination
      def cursor
        relation = add_params(cursorMark: '*')

        # Sort must include a sort on unique key (id).
        if /\bid\b/ =~ params[:sort]
          relation
        else
          relation.sort(params[:sort], 'id ASC')
        end
      end

      def cursor?
        params.key?(:cursorMark)
      end

      #
      # Commands
      #

      def insert(docs)
        # FIXME: use input schema
        data = Array.wrap(docs).map do |doc|
          doc.transform_keys!(&:to_sym)
          doc[:id] ||= UUID[]
          doc
        end

        with_options(
          base_path: 'update/json/docs',
          content_type: 'application/json',
          request_data: JSON.dump(data)
        )
      end

      def update(docs)
        # FIXME: use input schema
        data = Array.wrap(docs)
                 .map    { |doc| doc.transform_keys(&:to_sym) }
                 .select { |doc| doc.key?(:id) }

        with_options(
          base_path: 'update/json/docs',
          content_type: 'application/json',
          request_data: JSON.dump(data)
        )
      end

      def delete(docs)
        # FIXME: use input schema
        ids = Array.wrap(docs)
                .map { |doc| doc.transform_keys(&:to_sym) }
                .map { |doc| doc.fetch(:id) }

        with_options(
          base_path: 'update',
          content_type: 'application/json',
          request_data: JSON.dump(delete: ids)
        )
      end

      def delete_by_query(query)
        with_options(
          base_path: 'update',
          content_type: 'application/json',
          request_data: JSON.dump(delete: {query: query})
        )
      end

      #
      # Params
      #

      def q(query)
        add_params(q: Types::String[query])
      end
      alias_method :query, :q

      def fq(*filter)
        add_params(fq: filter)
      end
      alias_method :filter, :fq

      def fl(*fields)
        add_params(fl: fields.join(','))
      end
      alias_method :fields, :fl

      def cache(enabled = true)
        add_params(cache: Types::Bool[enabled])
      end

      def segment_terminate_early(enabled = true)
        add_params(segmentTerminateEarly: Types::Bool[enabled])
      end

      def time_allowed(millis)
        add_params(timeAllowed: Types::Coercible::Integer[millis])
      end

      def explain_other(query)
        add_params(explainOther: Types::String[query])
      end

      def start(offset)
        add_params(start: Types::Coercible::Integer[offset])
      end

      def sort(*criteria)
        # This implementation is very tentative
        new_sort = criteria.prepend(params[:sort]).compact.join(',')

        add_params(sort: new_sort)
      end

      def rows(num)
        add_params(rows: Types::Coercible::Integer[num])
      end
      alias_method :limit, :rows

      def def_type(value)
        add_params(defType: Types::Coercible::String[value])
      end

      def debug(setting)
        type = Types::Coercible::String
                 .enum('query', 'timing', 'results', 'all', 'true')

        add_params(debug: type[setting])
      end

      def echo_params(setting)
        type = Types::Coercible::String.enum('explicit', 'all', 'none')

        add_params(echoParams: type[setting])
      end

      def min_exact_count(num)
        add_params(minExactCount: Types::Coercible::Integer[num])
      end

      def commit(value = true)
        add_params(commit: Types::Bool[value])
      end

      def commit_within(millis)
        return self if millis.nil?

        add_params(commitWithin: Types::Coercible::Integer[millis])
      end

      def overwrite(value = true)
        add_params(overwrite: Types::Bool[value])
      end

      def expunge_deletes(value = true)
        add_params(expungeDeletes: Types::Bool[value])
      end

    end
  end
end
