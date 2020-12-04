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

    def fields(show_defaults: true)
      response = get('/schema/fields?showDefaults=%s' % show_defaults)
      response.fields
    end

    def field(field_name, show_defaults: true)
      response = get('/schema/fields/%s?showDefaults=%s' % [field_name, show_defaults])
      response.field
    end

    def unique_key
      @unique_key ||= get('/schema/uniquekey').uniqueKey
    end

    def field_types(show_defaults: true)
      response = get('/schema/fieldtypes?showDefaults=%s' % show_defaults)
      response.fieldTypes
    end

    def field_type(field_name, show_defaults: true)
      response = get('/schema/fieldtypes/%s?showDefaults=%s' % [field_name, show_defaults])
      response.fieldType
    end

    def field_names
      fields.map(&:name)
    end

    def field_type_names
      field_types.map(&:name)
    end

    def add_field(field)
      post('/schema', {"add-field"=>field})
    end

    def delete_field(field)
      post('/schema', {"delete-field"=>{"name"=>field.name}})
    end

    def replace_field(field)
      post('/schema', {"replace-field"=>field})
    end

    # real-time get
    def get(*ids)
      response = get('/get?id=%s' % ids.join(','))
      if response.key?(:doc)
        response.doc
      else
        response.response
      end
    end

    def index(*docs, commit: true)
      post('/update/json/docs?commit=%s' % commit, docs)
    end

    def delete(*ids)
      post('/update', delete: ids)
    end

    def query(params)
      q = JsonQuery.new(params)
      post('/query', q)
    end

  end
end
