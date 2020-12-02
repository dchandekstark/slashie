require "net/http"
require "uri"
require "json"

require "solrbee/version"
require "solrbee/base"
require "solrbee/schema"
require "solrbee/schema_api"
require "solrbee/collection"
require "solrbee/response"

module Solrbee
  class Error < StandardError; end

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

  def self.get(path)
    u = URI.join(solr_url, path)
    req = Net::HTTP::Get.new(u)
    res = connection.request(req)
    res.value
    Response.new(JSON.parse(res.body))
  end

end
