module ROM
  module Solr
    module ResponseValue

      def response_value(name, **kwargs)
        path = kwargs.fetch(:path, name)
        key  = kwargs.fetch(:key, name)

        class_eval <<-RUBY
          def #{name}
            root.with_path(#{path.inspect}).one.send(#{key.inspect})
          end
        RUBY
      end

    end
  end
end
