module Solrbee
  module ApiMethods

    def ping
      response = request('/admin/ping')
      response.status
    end

    def schema
      response = request('/schema')
      response.schema
    end

    def schema_name
      response = request('/schema/name')
      response.name
    end

    def schema_version
      response = request('/schema/version')
      response.version
    end

    def fields(**params)
      response = request('/schema/fields', params: params)
      response.fields
    end

    def field(field_name, **params)
      response = request('/schema/fields/%s' % field_name, params: params)
      response.field
    end

    def unique_key
      @unique_key ||= request('/schema/uniquekey').uniqueKey
    end

    def field_types(**params)
      response = request('/schema/fieldtypes', params: params)
      response.fieldTypes
    end

    def field_type(field_name, **params)
      response = request('/schema/fieldtypes/%s' % field_name, params: params)
      response.fieldType
    end

    def field_names
      fields.map(&:name)
    end

    def field_type_names
      field_types.map(&:name)
    end

    def modify_schema(commands)
      request('/schema', data: commands)
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
      response = request('/get', params: params.merge(id: ids.join(',')))
      response.doc || response.docs
    end

    def index(*docs, **params)
      request('/update/json/docs', data: docs, params: params)
    end
    alias_method :add, :index
    alias_method :update, :index

    def delete(*ids)
      request('/update', data: { delete: ids })
    end

    def query(params)
      request('/query', data: Query.new(params))
    end

  end
end
