module Solrbee
  class Schema < Base

    class Field < Base
      def multi_valued; multiValued; end
    end

    coerce_key :fields, Array[Field]

    def unique_key; uniqueKey; end

  end
end
