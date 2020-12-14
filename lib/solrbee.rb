require "solrbee/version"
require "solrbee/api_methods"
require "solrbee/query"
require "solrbee/cursor"
require "solrbee/client"

module Solrbee

  class Error < StandardError; end

  API_VERSION = 'V1'

  # Single-valued field types
  STRING  = "string"
  LONG    = "plong"
  INT     = "pint"
  DATE    = "pdate"
  BOOLEAN = "boolean"

  # Multi-valued field types
  MSTRING  = "strings"
  MLONG    = "plongs"
  MINT     = "pints"
  MDATE    = "pdates"
  MBOOLEAN = "booleans"

  # Base URL
  def self.solr_url
    ENV.fetch('SOLR_URL', 'http://localhost:8983/solr').sub(/\/\z/, '')
  end

end
