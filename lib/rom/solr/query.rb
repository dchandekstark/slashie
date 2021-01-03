# frozen_string_literal: true

require 'date'
require 'time'

module ROM
  module Solr
    module Query

      # Templates
      ABSENT      = '-%{field}:[* TO *]'
      BEFORE_DATE = '%{field}:[* TO %{value}]'
      BEFORE_DAYS = '%{field}:[* TO NOW-%{value}DAYS]'
      DISJUNCTION = '{!lucene q.op=OR df=%{field}}%{value}'
      JOIN        = '{!join from=%{from} to=%{to}}%{field}:%{value}'
      NEGATION    = '-%{field}:%{value}'
      PRESENT     = '%{field}:[* TO *]'
      REGEXP      = '%{field}:/%{value}/'
      STANDARD    = '%{field}:%{value}'
      TERM        = '{!term f=%{field}}%{value}'

      # Value transformers
      NOOP           = ->{ self }
      QUOTE          = ->{ ROM::Solr.quote(self) }
      ESCAPE_SLASHES = ->{ gsub(/\//, "\\/") }
      SOLR_DATE      = ->{ DateTime.parse(to_s).to_time.utc.iso8601 }
      INTEGER        = ->{ to_i }

      # Build standard query clause(s) -- i.e., field:value --
      # and disjunction clauses (i.e., when value is an array).
      #
      # @param mapping [Hash<<Symbol, String>, <String, Array<String>>]
      #   field=>value mapping
      # @return [Array<String>] queries
      def where(mapping)
        mapping.map do |field, value|
          if Array.wrap(value).size > 1
            render(DISJUNCTION, {field=>value}, ->{ map { |v| ROM::Solr.quote(v) }.join(' ') })
          else
            render(STANDARD, {field=>value}, QUOTE)
          end
        end.flatten
      end

      # Builds negation clause(s) -- i.e., -field:value
      #
      # @param mapping [Hash<<Symbol, String>, #to_s>] field=>value mapping
      # @return [QueryBuilder]
      # @return [Array<String>] queries
      def where_not(mapping)
        render(NEGATION, mapping, QUOTE)
      end

      # Builds query clause(s) to filter where field is present
      # (i.e., has one or more values)
      #
      # @param fields [Array<String>] on or more fields
      # @return [Array<String>] queries
      def present(*fields)
        fields.map { |field| PRESENT % {field: field} }
      end

      # Builds query clause(s) to filter where field is NOT present
      # (i.e., no values)
      #
      # @param fields [Array<Symbol, String>] one or more fields
      # @return [QueryBuilder]
      # @return [Array<String>] queries
      def absent(*fields)
        fields.map { |field| ABSENT % {field: field} }
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
        [ JOIN % { from: from, to: to, field: field, value: ROM::Solr.quote(value) } ]
      end

      # Builds query clause(s) to filter where date field value
      # is earlier than a date/time value.
      #
      # @param mapping [Hash<<Symbol, String>, Object>] field=>value mapping
      #   Values (coerced to strings) must be parseable by `DateTime.parse`.
      # @return [Array<String>] queries
      def before_date(mapping)
        render(BEFORE_DATE, mapping, SOLR_DATE)
      end

      # Builds query clause(s) to filter where date field value
      # is earlier than a number of days before now.
      #
      # @param mapping [Hash] field=>value mapping
      # @return [Array<String>] queries
      def before_days(mapping)
        render(BEFORE_DAYS, mapping, INTEGER)
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
        render(REGEXP, mapping, ESCAPE_SLASHES)
      end

      private

      def render(template, mapping, transformer = NOOP)
        mapping.map do |field, value|
          template % {field: field, value: value.instance_exec(&transformer)}
        end
      end

      extend self

    end
  end
end
