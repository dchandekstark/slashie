module ROM
  module Solr
    #
    # Extends a Relation to privode a convenience method for adding
    # simple query parameter methods.
    #
    # @example Creates instance method `#include_dynamic(value = true)`
    # that sets param :includeDynamic to the value argument.
    #
    # class MyRelation < ROM::Solr::Relation
    #   extend ROM::Solr::QueryParam
    #
    #   query_param :includeDynamic, as: :include_dynamic, type: Types::Bool.default(true)
    # end
    #
    module QueryParam

      def query_param(param, as = nil, type: Types::String)
        define_method param, ->(value) { add_params(param => type[value]) }
        alias_method as, param unless as.nil?
      end

    end
  end
end
