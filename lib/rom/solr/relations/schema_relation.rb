module ROM
  module Solr
    class SchemaRelation < Relation

      schemaless(:schema, as: :schema_info)

      Solrbee::Api.config.schema.api.each do |method, config|
        method_name = config.method_name || method

        define_method(method_name) do |*args, **kwargs|
          config_args = Array.wrap(config.args).map(&:to_sym)
          args_hash = config_args.zip(args).to_h

          params = config.params.to_h.merge(kwargs)

          path = config.path ? config.path % args_hash : nil

          with_path(path)
            .with_enum_on(config.enum_on)
            .add_params(params)
            .fetch(config.fetch_key)
        end
      end

    end
  end
end
