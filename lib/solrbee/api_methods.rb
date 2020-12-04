module Solrbee
  module ApiMethods

    def schema_name
      response = get('/schema/name')
      response.name
    end

    def schema_version
      response = get('/schema/version')
      response.version
    end

    def schema
      response = get('/schema')
      response.schema
    end

    def fields(**params)
      response = get('/schema/fields', **params)
      response.fields
    end

    def field(field_name, **params)
      response = get('/schema/fields/%s' % field_name, **params)
      response.field
    end

    def unique_key
      @unique_key ||= get('/schema/uniquekey').uniqueKey
    end

    def field_types(**params)
      response = get('/schema/fieldtypes', **params)
      response.fieldTypes
    end

    def field_type(field_name, **params)
      response = get('/schema/fieldtypes/%s' % field_name, **params)
      response.fieldType
    end

    def field_names
      fields.map(&:name)
    end

    def field_type_names
      field_types.map(&:name)
    end

    def modify_schema(commands)
      post('/schema', commands)
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
    # Note: Using POST here for simpler params.
    def get_by_id(*ids)
      response = post('/get', params: { id: ids })
      response.doc || response.docs
    end

    def index(*docs, **params)
      post('/update/json/docs', docs, **params)
    end
    alias_method :add, :index
    alias_method :update, :index

    def delete(*ids)
      post('/update', delete: ids)
    end

    def query(params)
      post('/query', Query.new(params))
    end

  end
end
