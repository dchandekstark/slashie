module Solrbee
  module ApiMethods

    def ping
      response = Request.execute(self, '/admin/ping')
      response.status
    end

    def schema
      response = Request.execute(self, '/schema')
      response.schema
    end

    def schema_name
      response = Request.execute(self, '/schema/name')
      response.name
    end

    def schema_version
      response = Request.execute(self, '/schema/version')
      response.version
    end

    def fields(**params)
      response = Request.execute(self, '/schema/fields', params: params)
      response.fields
    end

    def field(field_name, **params)
      response = Request.execute(self, '/schema/fields/%s' % field_name, params: params)
      response.field
    end

    def unique_key
      @unique_key ||= Request.execute(self, '/schema/uniquekey').uniqueKey
    end

    def field_types(**params)
      response = Request.execute(self, '/schema/fieldtypes', params: params)
      response.fieldTypes
    end

    def field_type(field_name, **params)
      response = Request.execute(self, '/schema/fieldtypes/%s' % field_name, params: params)
      response.fieldType
    end

    def field_names
      fields.map(&:name)
    end

    def field_type_names
      field_types.map(&:name)
    end

    def modify_schema(commands)
      Request.execute(self, '/schema', data: commands)
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
      response = Request.execute(self, '/get', params: { id: ids.join(',') })
      response.doc || response.docs
    end

    def index(*docs, **params)
      Request.execute(self, '/update/json/docs', data: docs, params: params)
    end
    alias_method :add, :index
    alias_method :update, :index

    def delete(*ids)
      Request.execute(self, '/update', data: { delete: ids })
    end

    def query(params)
      Request.execute(self, '/query', data: Query.new(params))
    end

  end
end
