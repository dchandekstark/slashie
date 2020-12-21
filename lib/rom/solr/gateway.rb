module ROM
  module Solr
    class Gateway < ROM::HTTP::Gateway

      adapter :solr

      def initialize(config = {})
        config[:uri]     ||= ENV.fetch('SOLR_URL', 'http://localhost:8983/solr')
        config[:headers] ||= { Accept: 'application/json' }
        super
      end

      def dataset(name)
        dataset_class(name).new config.merge(base_path: name)
      end

      def dataset_class(name)
        prefix = name.to_s.split(/[_\/]/).map(&:capitalize).join('')
        const_name = "#{prefix}Dataset"
        ROM::Solr.const_defined?(const_name, false) ? ROM::Solr.const_get(const_name, false) : Dataset
      end

    end
  end
end
