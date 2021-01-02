require 'delegate'

module ROM
  module Solr
    module QueryTemplates

      #
      # Simple template object with a `#render` method.
      #
      # N.B. Values must be properly escaped and/or
      # formatted for Solr prior to rendering!
      #
      class Template < SimpleDelegator
        # @param data [Hash]
        def render(data)
          __getobj__ % data
        end
      end

      STANDARD    = Template.new('%{field}:%{value}')

      ABSENT      = Template.new('-%{field}:[* TO *]')
      BEFORE_DATE = Template.new('%{field}:[* TO %{value}]')
      BEFORE_DAYS = Template.new('%{field}:[* TO NOW-%{value}DAYS]')
      DISJUNCTION = Template.new('{!lucene q.op=OR df=%{field}}%{value}')
      JOIN        = Template.new('{!join from=%{from} to=%{to}}%{field}:%{value}')
      NEGATION    = Template.new('-%{field}:%{value}')
      PRESENT     = Template.new('%{field}:[* TO *]')
      REGEXP      = Template.new('%{field}:/%{value}/')
      TERM        = Template.new('{!term f=%{field}}%{value}')

    end
  end
end
