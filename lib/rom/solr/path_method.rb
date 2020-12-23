module ROM
  module Solr
    module PathMethod

      def path_method(path, as: nil)
        define_method path, ->{ with_path(path) }
        alias_method as, path unless as.nil?
      end

    end
  end
end
