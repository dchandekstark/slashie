module ROM
  module Solr
    class Relation < ROM::HTTP::Relation

      adapter :solr

      forward :remove_params, :add_values, :default_params

      private

      def response
        dataset.response
      end

    end
  end
end
