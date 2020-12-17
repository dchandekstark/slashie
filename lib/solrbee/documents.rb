module Solrbee
  class Documents < ROM::Relation[:solr]

    schema(:select) do
      attribute :id, ROM::HTTP::Types::String
    end

    def all
      query('*:*')
    end

  end
end
