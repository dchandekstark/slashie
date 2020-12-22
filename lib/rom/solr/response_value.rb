module ROM
  module Solr
    #
    # Extends a Repository by adding a convenience method for
    # fetching a value from a relation.
    #
    module ResponseValue

      def response_value(name, key: nil)
        __key__ = key || name

        define_method name, ->{ root.send(name).one.send(__key__) }
      end

    end
  end
end
