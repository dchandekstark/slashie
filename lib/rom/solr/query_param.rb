module ROM
  module Solr
    module QueryParam

      def query_param(name, **kwargs)
        param   = kwargs.fetch(:param, name)
        default = kwargs[:default]

        class_eval <<-RUBY
          def #{name}(value = #{default.inspect})
            add_params(#{param}: value)
          end
        RUBY
      end

    end
  end
end
