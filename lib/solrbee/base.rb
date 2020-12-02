require 'hashie'

module Solrbee
  class Base < Hashie::Hash
    include Hashie::Extensions::Coercion
    include Hashie::Extensions::MergeInitializer
    include Hashie::Extensions::MethodAccess
  end

  Field     = Class.new(Base)
  FieldType = Class.new(Base)
  Header    = Class.new(Base)
  Schema    = Class.new(Base)
end
