# frozen_string_literal: true

module ROM
  module Solr
    #
    # A module of static methods, each of which returns an array of Solr queries,
    # which is intended to function as a DSL in the context of a QueryBuilder.
    #
    module Query

      ANY_VALUE = '[* TO *]'

      # Templates
      DISJUNCTION = '{!lucene q.op=OR df=%{field}}%{value}'
      JOIN        = '{!join from=%{from} to=%{to}}%{field}:%{value}'
      NEGATION    = '-%{field}:%{value}'
      STANDARD    = '%{field}:%{value}'
      TERM        = '{!term f=%{field}}%{value}'

      # Value transformers
      NOOP          = ->(v) { v }
      REGEX         = ->(v) { Utils.regex(v) }
      BEFORE_DATE   = ->(v) { '[* TO %s]' % Utils.solr_date(v) }
      AFTER_DATE    = ->(v) { '[%s TO NOW]' % Utils.solr_date(v) }
      BETWEEN_DATES = ->(v) { '[%s TO %s]' % v.map { |d| Utils.solr_date(d) } }
      EXACT_DATE    = ->(v) { Utils.escape(Utils.solr_date(v)) }

      # Build standard query clause(s) -- i.e., field:value --
      # and disjunction clauses (i.e., when value is an array).
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def where(**mapping)
        lists   = mapping.select { |v| Array.wrap(v).length > 1 }
        scalars = mapping.reject { |k, v| lists.key?(k) }

        render(STANDARD, **scalars) + render(DISJUNCTION, **lists)
      end

      # Builds negation clause(s) -- i.e., -field:value
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def where_not(**mapping)
        render(NEGATION, **mapping)
      end

      # Builds query clause(s) to filter where field is present
      # (i.e., has one or more values)
      #
      # @param fields [Array<String>] on or more fields
      # @return [Array<String>] queries
      def exist(*fields)
        mapping = fields.map { |field| [field, ANY_VALUE] }.to_h

        render(STANDARD, **mapping)
      end

      # Builds query clause(s) to filter where field is NOT present
      # (i.e., no values)
      #
      # @param fields [Array<Symbol, String>] one or more fields
      # @return [Array<String>] queries
      def not_exist(*fields)
        mapping = fields.map { |field| [field, ANY_VALUE] }.to_h

        render(NEGATION, **mapping)
      end

      # Builds a Solr join clause
      #
      # @see https://wiki.apache.org/solr/Join
      # @param from [String]
      # @param to [String]
      # @param field [String]
      # @param value [String]
      # @return [Array<String>] queries
      def join(from:, to:, field:, value:)
        [ JOIN % { from: from, to: to, field: field, value: value } ]
      end

      # Builds query clause(s) to filter where date field value
      # is earlier than a date/time value.
      #
      # @param mapping [Hash] field=>value mapping
      #   Values (coerced to strings) must be parseable by `DateTime.parse`.
      # @return [Array<String>] queries
      def before(**mapping)
        render(STANDARD, BEFORE_DATE, **mapping)
      end

      # Builds query clause(s) to filter where date field value
      # is later than a date/time value.
      #
      # @param mapping [Hash] field=>value mapping
      #   Values (coerced to strings) must be parseable by `DateTime.parse`.
      # @return [Array<String>] queries
      def after(**mapping)
        render(STANDARD, AFTER_DATE, **mapping)
      end

      # Builds query clause(s) to filter where date field value
      # is between two dates (inclusive).
      #
      # @example
      #   between_dates(published: ['2019-01-01 00:00:00', '2019-12-31 23:59:59'])
      # @param mapping [Hash] field=>[value, value] mapping
      #   Values (coerced to strings) must be parseable by `DateTime.parse`.
      # @return [Array<String>] queries
      def between_dates(**mapping)
        render(STANDARD, BETWEEN_DATES, **mapping)
      end

      def exact_date(**mapping)
        render(STANDARD, EXACT_DATE, **mapping)
      end

      # Builds term query clause(s) to filter where field contains value.
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def term(**mapping)
        render(TERM, **mapping)
      end

      # Builds regular expression query clause(s).
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def regex(**mapping)
        render(STANDARD, REGEX, **mapping)
      end

      private

      def render(template, transformer = NOOP, **mapping)
        mapping.transform_values(&transformer).map do |field, value|
          template % {field: field, value: value}
        end
      end

      extend self
    end
  end
end
