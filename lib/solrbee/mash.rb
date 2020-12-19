require "hashie"

module Solrbee
  class Mash < Hashie::Mash

    include Hashie::Extensions::Mash::SymbolizeKeys

    disable_warnings

  end
end
