module Solrbee
  #
  #
  #
  # client = Solrbee::Client.new('mycollection'))
  # cursor = Solrbee::Cursor.new(client)
  # query = { query: 'foo:bar', sort: 'title ASC', limit: 10 }
  # results = cursor.execute(query)
  # results.each do |doc|
  #   ...
  # end
  #
  class Cursor

    CURSOR_MARK = '*'

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def execute(query)
      Enumerator.new do |yielder|
        q = prepare_query(query)
        while true
          response = client.query(q)
          break if response.num_found == 0
          break if response.nextCursorMark == q.params.cursorMark
          response.docs.each { |doc| yielder << doc }
          q.params.cursorMark = response.nextCursorMark
        end
      end
    end

    private

    def unique_key_sort
      '%s ASC' % client.unique_key
    end

    def prepare_query(query)
      Query.new(query).tap do |q|
        q.params[:cursorMark] = CURSOR_MARK

        if q.sort?
          unless q.sort =~ /\b#{client.unique_key}\b/
            q.sort += unique_key_sort
          end
        else
          q.sort = unique_key_sort
        end
      end
    end

  end
end
