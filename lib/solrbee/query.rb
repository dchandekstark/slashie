require 'hashie'

module Solrbee
  #
  # A query targeting the JSON Request API.
  #
  class Query < Hashie::Trash

    property :query,  from: :q,     default: '*:*'
    property :filter, from: :fq
    property :limit,  from: :rows,  default: 10
    property :fields, from: :fl
    property :sort
    property :offset, from: :start
    property :facet
    property :queries
    property :params, default: {}

  end
end
