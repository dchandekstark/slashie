module Solrbee
  module ApiMethods

    def ping
      response = request(path: '/admin/ping')
      response['status']
    end

    def schema
      response = request(path: '/schema')
      response['schema']
    end

    def schema_name
      response = request(path: '/schema/name')
      response['name']
    end

    def schema_version
      response = request(path: '/schema/version')
      response['version']
    end

    def fields(**params)
      response = request(path: '/schema/fields', params: params)
      response['fields']
    end

    def field(field_name, **params)
      response = request(path: '/schema/fields/%s' % field_name, params: params)
      response['field']
    end

    def unique_key
      response = request(path: '/schema/uniquekey')
      response['uniqueKey']
    end

    def field_types(**params)
      response = request(path: '/schema/fieldtypes', params: params)
      response['fieldTypes']
    end

    def field_type(field_name, **params)
      response = request(path: '/schema/fieldtypes/%s' % field_name, params: params)
      response['fieldType']
    end

    def field_names
      fields.map { |f| f['name'] }
    end

    def field_type_names
      field_types.map { |f| f['name'] }
    end

    def modify_schema(commands)
      request(path: '/schema', data: commands)
    end

    def add_field(field)
      modify_schema("add-field"=>field)
    end

    def delete_field(field_name)
      modify_schema("delete-field"=>{"name"=>field_name})
    end

    def replace_field(field)
      modify_schema("replace-field"=>field)
    end

    # "real-time get"
    def get_by_id(*ids, **params)
      response = request(path: '/get', params: params.merge(id: ids.join(',')))
      response['response']['doc'] || response['response']['docs']
    end

    def index(*docs, **params)
      request(path: '/update/json/docs', data: docs, params: params)
    end
    alias_method :add, :index
    alias_method :update, :index

    def delete(*ids)
      request(path: '/update', data: { delete: ids })
    end

    def query(**params)
      request(path: '/query', data: params)
    end

  end
end
