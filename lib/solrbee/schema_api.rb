module Solrbee
  class SchemaApi

    attr_reader :collection

    def initialize(collection)
      @collection = collection
    end

    def to_h
      content
    end

    def name
      response = Solrbee.get('%s/schema/name' % collection)
      response.name
    end

    def version
      response = Solrbee.get('%s/schema/version' % collection)
      response.version
    end

    def content
      response = Solrbee.get('%s/schema' % collection)
      response.schema
    end

    def fields(show_defaults: true)
      response = Solrbee.get('%s/schema/fields?showDefaults=%s' % [collection, show_defaults])
      response.fields
    end

    def field(field_name, show_defaults: true)
      response = Solrbee.get('%s/schema/fields/%s?showDefaults=%s' % [collection, field_name, show_defaults])
      response.field
    end

    def unique_key
      response = Solrbee.get('%s/schema/uniquekey' % collection)
      response.uniqueKey
    end

    def field_types(show_defaults: true)
      response = Solrbee.get('%s/schema/fieldtypes?showDefaults=%s' % [collection, show_defaults])
      response.fieldTypes
    end

    def field_type(field_name, show_defaults: true)
      response = Solrbee.get('%s/schema/fieldtypes/%s?showDefaults=%s' % [collection, field_name, show_defaults])
      response.fieldType
    end

    def field_names
      fields.map(&:name)
    end

    def field_type_names
      field_types.map(&:name)
    end

    def index(*docs, commit: true)
      Solrbee.post('%s/update/json/docs?commit=%s' % [collection, commit], docs)
    end

    def add_field(field)
      data = { "add-field" => field }
      Solrbee.post('%s/schema' % collection, data)
    end

    def delete_field(field)
      data = {
        "delete-field" => {
          "name" => field.name
        }
      }
      Solrbee.post('%s/schema' % collection, data)
    end

    def replace_field(field)
      data = { "replace-field" => field }
      Solrbee.post('%s/schema' % collection, data)
    end

  end
end
