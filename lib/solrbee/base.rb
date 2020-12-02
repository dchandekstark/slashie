require 'hashie'

module Solrbee
  class Base < Hashie::Hash
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::SymbolizeKeys
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::MethodReader
  end
end
