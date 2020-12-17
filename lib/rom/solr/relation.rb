module ROM
  module Solr
    class Relation < ROM::HTTP::Relation
      adapter :solr

      forward :query, :sort

      def all
        self
      end

    end
  end
end
