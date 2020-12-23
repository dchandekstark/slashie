module ROM
  module Solr
    #
    # Extends a Repository by adding a convenience method for
    # fetching a value from a relation.
    #
    module ResponseValue

      def response_value(name, key: nil)
        __key__ = key || name

        define_method name, ->{
          response = root.send(name).one
          auto_struct ? response.send(__key__) : response[__key__]
        }
      end

    end
  end
end
