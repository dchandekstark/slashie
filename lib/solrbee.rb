require "solrbee/version"
require "solrbee/response"
require "solrbee/query"
require "solrbee/client"
require "solrbee/cursor"

module Solrbee

  class Error < StandardError; end

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
