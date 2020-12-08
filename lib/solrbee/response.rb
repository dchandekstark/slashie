require 'hashie'

module Solrbee
  class Response < Hashie::Mash

    def initialize(http_response)
      super JSON.parse(http_response.body)
    end

    disable_warnings

    def header
      responseHeader
    end

    def num_found
      response.numFound
    end

    def docs
      response.docs
    end

    def doc
      response.doc
    end

  end
end
