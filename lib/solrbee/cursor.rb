module Solrbee
  #
  # Summary
  #
  # > client = Solrbee::Client.new('mycollection'))
  # > cursor = Solrbee::Cursor.new(client)
  # > query = { query: 'foo:bar', sort: 'title ASC', limit: 10 }
  # > results = cursor.execute(query)
  # > results.each do |doc|
  #   ...
  # > end
  #
  class Cursor

    attr_reader :client

    def initialize(client)
      @client = client
    end

    # @return [Enumerator] an enumerator of query results
    def execute(query)
      Enumerator.new do |yielder|
        q = Query.cursor(query, client.unique_key)

        while true
          response = client.query(q)
          break if response.num_found == 0
          break if response.nextCursorMark == q.params.cursorMark
          response.docs.each { |doc| yielder << doc }
          q.params.cursorMark = response.nextCursorMark
        end
      end
    end

  end
end
