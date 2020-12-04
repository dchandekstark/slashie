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

    # Build a query for a Cursor
    def self.cursor(params, unique_key)
      Query.new(params).tap do |q|
        q.delete(:offset)           # incompatible with cursor
        q.params[:cursorMark] = '*' # initial cursor mark

        # Sort on unique key is required for cursor
        q.sort = "#{unique_key} ASC" unless q.sort
        unless q.sort =~ /\b#{unique_key}\b/
          clauses = q.sort.split(/,/)
          clauses << "#{unique_key} ASC"
          q.sort = clauses.join(',')
        end
      end
    end

  end
end
