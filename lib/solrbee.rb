require 'yaml'

module Solrbee

  API_VERSION = 'v1'

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

  def self.api
    @api ||= YAML.load_file(File.expand_path('../../config/api.yml', __FILE__))[API_VERSION]
  end

end

require "solrbee/version"
require "solrbee/api"
require "solrbee/query"
require "solrbee/cursor"
require "solrbee/client"
