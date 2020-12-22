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
    #   query_param :include_dynamic, param: :includeDynamic, type: Types::Bool.default(true)
    # end
    #
    module QueryParam

      def query_param(name, param: nil, type: Types::String, repeatable: nil)
        __param__ = ( param || name ).to_sym

        meth = Proc.new do |value = nil|
          __value__ = type[value]

          if params.key?(__param__)
            raise "The query parameter `#{__param__}' is not repeatable." if !repeatable

            add_param_value(__param__, __value__)
          else
            add_params(__param__ => __value__)
          end
        end

        define_method(name, meth)
      end

    end
  end
end
