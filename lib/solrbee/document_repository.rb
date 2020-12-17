module Solrbee
  class DocumentRepository < ROM::Repository[:select]
    relations :select
  end
end
