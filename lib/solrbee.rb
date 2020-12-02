require "net/http"
require "uri"
require "json"

require "solrbee/version"
require "solrbee/base"
require "solrbee/response"
require "solrbee/collection"
require "solrbee/schema_api"

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

  def self.solr_url
    ENV.fetch('SOLR_URL', 'http://localhost:8983/solr/')
  end

  def self.solr_uri
    URI(solr_url)
  end

  def self.connection
    Net::HTTP.new(solr_uri.host, solr_uri.port).tap do |http|
      http.use_ssl = true if solr_uri.scheme == 'https'
    end
  end

  def self.request_class(method)
    Net::HTTP.const_get(method.to_s.downcase.capitalize)
  end

  def self.request(method, path)
    u = URI.join(solr_url, path)
    req = request_class(method).new(u, {'Accept'=>'application/json'})
    yield req if block_given?
    res = connection.request(req)
    Response.handle(res)
  end

  def self.get(path)
    request(:get, path)
  end

  def self.post(path, data)
    request(:post, path) do |req|
      req['Content-Type'] = 'application/json'
      req.body = JSON.dump(data)
    end
  end

end
