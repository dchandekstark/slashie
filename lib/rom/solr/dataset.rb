require 'rom/solr/paginated_dataset'
require 'solrbee/cache'

module ROM
  module Solr
    class Dataset < ROM::HTTP::Dataset

      configure do |config|
        config.default_response_handler = Response
        config.default_request_handler = Request
      end

      def remove_params(*keys)
        keep = params.keys - keys
        with_params params.slice(*keep)
      end

      def add_values(key, val)
        params[key] = Array(params[key]) | Array(val)
      end

      # @override
      def add_params(new_params)
        with_params params.merge(new_params)
      end

      def default_params(defaults)
        with_params defaults.merge(params)
      end

      def param?(key)
        params.key?(key)
      end

      def filter(*fq)
        add_values(:fq, fq)
      end
      alias_method :fq, :filter

      def query(q)
        add_params(q: q)
      end
      alias_method :q, :query

      def fields(*fl)
        add_params(fl: fl)
      end
      alias_method :fl, :fields

      def start(offset)
        add_params(start: offset.to_i)
      end
      alias_method :offset, :start

      def rows(limit)
        add_params(rows: limit.to_i)
      end
      alias_method :limit, :rows

      def sort(crit)
        add_params(sort: crit)
      end

      # @override
      def each
        return to_enum unless block_given?

        pages.each do |page|
          page.docs.each do |doc|
            yield doc
          end
        end
      end

      def count
        response['response']['numFound']
      end
      alias_method :num_found, :count

      def docs
        response['response']['docs']
      end

      # @override
      def response
        cache.load(:response) { super }
      end

      private

      def cache
        @cache ||= Solrbee::Cache.new
      end

      def pages
        PaginatedDataset.new(self)
      end

    end
  end
end
