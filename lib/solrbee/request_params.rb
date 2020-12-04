require 'hashie'

module Solrbee
  #
  # For marshalling various API request query parameters
  #
  class RequestParams < Hashie::Trash
    property :showDefaults,   from: :show_defaults
    property :includeDynamic, from: :include_dynamic
    property :fl
    property :commit
  end
end
