module ROM
  module Solr
    module PathMethod

      def path_method(name, path: nil)
        class_eval <<-RUBY
          def #{name}
            with_path('#{path || name}')
          end
        RUBY
      end

    end
  end
end
