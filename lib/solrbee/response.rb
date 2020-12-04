require 'hashie'

module Solrbee
  class Response < Hashie::Mash

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

  end
end
