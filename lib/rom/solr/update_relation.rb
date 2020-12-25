module ROM
  module Solr
    class UpdateRelation < Relation

      def delete
        with_data(delete: map(&:id))
      end

    end
  end
end
