# frozen_string_literal: true

module ROM
  module Solr
    module Query
      include Utils

      ANY_VALUE = '[* TO *]'
      OR        = ' OR '
      AND       = ' AND '

      # Templates
      DISJUNCTION = '{!lucene q.op=OR df=%{field}}%{value}'
      JOIN        = '{!join from=%{from} to=%{to}}%{field}:%{value}'
      NEGATION    = '-%{field}:%{value}'
      REGEXP      = '%{field}:/%{value}/'
      STANDARD    = '%{field}:%{value}'
      TERM        = '{!term f=%{field}}%{value}'

      # Value transformers
      NOOP          = ->(v) { v }
      ESCAPE        = ->(v) { escape(v) }
      INTEGER       = ->(v) { v.to_i }
      BEFORE_DATE   = ->(v) { '[* TO %s]' % solr_date(v) }
      AFTER_DATE    = ->(v) { '[%s TO NOW]' % solr_date(v) }
      BETWEEN_DATES = ->(a, b) { '[%s TO %s]' % [solr_date(a), solr_date(b)] }
      EXACT_DATE    = ->(v) { escape(solr_date(v)) }

      # Build standard query clause(s) -- i.e., field:value --
      # and disjunction clauses (i.e., when value is an array).
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def where(mapping)
        render(STANDARD, mapping, ->(v) { Array.wrap(v).join(OR) })
      end

      # Builds negation clause(s) -- i.e., -field:value
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def where_not(mapping)
        render(NEGATION, mapping)
      end

      # Builds query clause(s) to filter where field is present
      # (i.e., has one or more values)
      #
      # @param fields [Array<String>] on or more fields
      # @return [Array<String>] queries
      def exist(*fields)
        mapping = fields.map { |field| {field: field, value: ANY_VALUE} }

        render(STANDARD, mapping)
      end

      # Builds query clause(s) to filter where field is NOT present
      # (i.e., no values)
      #
      # @param fields [Array<Symbol, String>] one or more fields
      # @return [Array<String>] queries
      def not_exist(*fields)
        mapping = fields.map { |field| {field: "-#{field}", value: ANY_VALUE} }

        render(STANDARD, mapping)
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
      def before(mapping)
        render(STANDARD, mapping, BEFORE_DATE)
      end

      # Builds query clause(s) to filter where date field value
      # is later than a date/time value.
      #
      # @param mapping [Hash] field=>value mapping
      #   Values (coerced to strings) must be parseable by `DateTime.parse`.
      # @return [Array<String>] queries
      def after(mapping)
        render(STANDARD, mapping, AFTER_DATE)
      end

      def between_dates(mapping)
        render(STANDARD, mapping, BETWEEN_DATES)
      end

      def exact_date(mapping)
        render(STANDARD, mapping, EXACT_DATE)
      end

      # Builds term query clause(s) to filter where field contains value.
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def term(mapping)
        render(TERM, mapping)
      end

      # Builds regular expression query clause(s).
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def regexp(mapping)
        render(REGEXP, mapping, ESCAPE_SLASHE)
      end

      private

      def render(template, mapping, transformer = NOOP)
        mapping.transform_values(&transformer).map do |field, value|
          template % {field: field, value: value}
        end
      end

      extend self
    end
  end
end
