module Solrbee
  module Api

    # Generate API methods
    Solrbee.api.each do |name, config|
      path = config.fetch('path')
      data = config['data']

      define_method(name.to_sym) do |args = {}|
        response = request(
          path: path % args,
          params: args.fetch(:params, {}),
          data: args[:data]
        )
        if k = config['response_key']
          response[k]
        else
          response
        end
      end
    end

    # def index(*docs, **params)
    #   request(path: '/update/json/docs', data: docs, params: params)
    # end

    # def query(**params)
    #   request(path: '/query', data: params)
    # end

    #
    # Schema methods
    #
    def field_names
      fields.map { |f| f['name'] }
    end

    def field_type_names
      field_types.map { |f| f['name'] }
    end

    def add_field(field)
      schema(data: {"add-field"=>field})
    end

    def delete_field(name)
      schema(data: {"delete-field"=>name})
    end

    def replace_field(field)
      schema(data: {"replace-field"=>{"name"=>field}})
    end

    #
    # Update methods
    #
    def delete_by_id(*ids)
      update(data: {delete: ids})
    end

  end
end
