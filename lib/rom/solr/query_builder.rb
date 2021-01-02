require 'date'
require 'time'

require 'rom/solr/query_templates'

module ROM
  module Solr
    class QueryBuilder

      QUOTE = '"'.freeze
      SPACE = ' '.freeze
      NOOP_TRANSFORM = proc { self }
      QUOTE_VALUE    = proc { quote(self) }

      include QueryTemplates

      attr_reader :clauses

      def initialize
        @clauses = []
      end

      # @param value [String]
      def quote(value)
        # Derived from Blacklight::Solr::SearchBuilderBehavior#solr_param_quote
        unless value =~ /\A[a-zA-Z0-9$_\-\^]+\z/
          QUOTE + value.gsub("'", "\\\\\'").gsub('"', "\\\\\"") + QUOTE
        else
          value
        end
      end

      # Build standard field:value query clause(s)
      # @param mapping [Hash] field=>value mapping
      def where(mapping)
        mapping.each do |field, value|
          if Array.wrap(value).size > 1
            disjunction(field => value)
          else
            clauses << STANDARD.render(field: field, value: quote(value))
          end
        end

        self
      end

      # Builds negation clause(s) -- i.e., -field:value
      # @param mapping [Hash] field=>value mapping
      def where_not(mapping)
        mapping.each do |field, value|
          clauses << NEGATION.render(field: field, value: quote(value))
        end

        self
      end

      # Builds query clause(s) to filter where field is present
      # (i.e., has one or more values)
      # @param fields [Array<String>]
      def present(*fields)
        fields.each { |field| clauses << PRESENT.render(field: field) }

        self
      end

      # Builds query clause(s) to filter where field is NOT present
      # (i.e., no values)
      # @param fields [Array<String>]
      def absent(*fields)
        fields.each { |field| clauses << ABSENT.render(field: field) }

        self
      end

      # Builds query clause(s) to filter where field contains
      # at least one of a set of values.
      # @param mapping [Hash] field=>value mapping
      def disjunction(mapping)
        mapping.each do |field, value|
          clauses << DISJUNCTION.render(
            field: field,
            value: value.map { |v| quote(v) }.join(SPACE)
          )
        end

        self
      end

      # Builds a Solr join clause
      # @see https://wiki.apache.org/solr/Join
      # @param from [String]
      # @param to [String]
      # @param field [String]
      # @param value [String]
      def join(from:, to:, field:, value:)
        clauses << JOIN.render(from: from, to: to, field: field, value: quote(value))

        self
      end

      # Builds query clause(s) to filter where date field value
      # is earlier than a date/time value.
      # @param mapping [Hash] field=>value mapping
      def before_date(mapping)
        mapping.each do |field, value|
          clauses << BEFORE_DATE.render(
            field: field,
            value: DateTime.parse(value.to_s).to_time.utc.iso8601
          )
        end

        self
      end

      # Builds query clause(s) to filter where date field value
      # is earlier than a number of days before now.
      # @param mapping [Hash] field=>value mapping
      def before_days(mapping)
        mapping.each do |field, value|
          clauses << BEFORE_DAYS.render(
            field: field,
            value: Types::Coercible::Integer[value]
          )
        end

        self
      end

      # Builds term query clause(s) to filter where field contains value.
      # @param mapping [Hash] field=>value mapping
      def term(mapping)
        mapping.each do |field, value|
          clauses << TERM.render(field: field, value: value)
        end

        self
      end

      # Builds regular expression query clause(s).
      # @param mapping [Hash] field=>value mapping
      def regexp(mapping)
        mapping.each do |field, value|
          clauses << REGEXP.render(field: field, value: value.gsub(/\//, "\\/"))
        end

        self
      end

    end
  end
end
