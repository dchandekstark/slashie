require 'date'
require 'time'

module ROM
  module Solr
    module Utils

      def phrase(value)
        if value.match?(/ /)
          '"%s"' % value.gsub(/"/, '\"')
        else
          value
        end
      end

      # Escape a Solr query value
      #
      # @param value [String] raw value
      # @return [String] escaped value
      def escape(value)
        value
          .gsub(ESCAPE_CHARS, '\\1')
          .gsub(DOUBLE_AMPERSAND, '\&\&')
          .gsub(DOUBLE_PIPE, '\|\|')
      end

      # Formats a value as a Solr date.
      def solr_date(value)
        DateTime.parse(value.to_s).to_time.utc.iso8601
      end

      extend self

    end
  end
end
