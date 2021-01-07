# frozen_string_literal: true

require 'date'
require 'time'

module ROM
  module Solr
    module Utils

      # Special characters in Solr (individual characters, not including '&&' and '||')
      SPECIAL_CHARS = '+-!(){}[]^"~*?:/&|\\' # plus white space

      # Regular expression for escaping special characters
      ESCAPE_CHARS = Regexp.new('(?<!\\\)([%s\s])' % Regexp.escape(SPECIAL_CHARS))

      # A Solr regular expression string
      SOLR_REGEX = Regexp.new('\A/.*/\z')

      # A quoted string
      QUOTED = Regexp.new('\A".*"\z')

      # strftime format for Solr-compatible date values
      SOLR_DATE_FORMAT = '%FT%TZ'

      # Enclose a string in double quotes (escaping internal quotes unless
      # already escaped). A value already enclosed in double-quotes is
      # returned unchanged.
      # @param value [String] the value to quote
      # @return [String] the quoted value
      def quote(value)
        return value if quoted?(value)

        '"%s"' % value.gsub(/(?<!\\)"/, '\"')
      end

      # Test whether a value is quoted.
      # @param value [String] the value to test
      # @return [Boolean] the result
      def quoted?(value)
        value.match?(QUOTED)
      end

      # Constructs a Solr regex query value.
      # This routine only escapes unescaped slashes internal to the
      # regular expression.
      #
      # @param value [String] raw value
      # @return [String] regex value
      def regex(value)
        if value.match?(SOLR_REGEX)
          regex(value[1..-2])
        else
          '/%s/' % value.gsub(/(?<!\\)\//, '\/')
        end
      end

      # Escape a Solr query value.
      # A quoted value is returned unchanged.
      #
      # N.B. A value containing intended special characters, such as
      # wildcards should NOT be passed through this function.
      #
      # @param value [String] raw value
      # @return [String] escaped value
      def escape(value)
        return value if quoted?(value)

        value.gsub(ESCAPE_CHARS, '\\\\\1')
      end

      # Formats a value as a Solr date.
      # @param value [Time, Date, DateTime, String, #to_s] the original value.
      # @return [String] a Solr-compatible date.
      def solr_date(value)
        case value
        when DateTime, Date
          solr_date value.to_time
        when Time
          value.utc.strftime SOLR_DATE_FORMAT
        else
          solr_date Time.parse(value.to_s)
        end
      end

      extend self

    end
  end
end
