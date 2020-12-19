module ROM
  module Solr
    class MashResponseHandler < ResponseHandler

      # @return [Solrbee::Mash]
      def self.call(response, dataset)
        Solrbee::Mash.new(super)
      end

    end
  end
end
