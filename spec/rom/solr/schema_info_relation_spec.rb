require 'rom/solr/relations/schema_info_relation'

module ROM::Solr
  RSpec.describe SchemaInfoRelation do

    let(:container) do
      ROM.container(:solr, uri: 'http://localhost:8983/solr/solrbee') do |config|
	config.register_relation(SchemaInfoRelation)
      end
    end

    let(:schema_info) { container.relations[:schema_info] }

    describe "#show_defaults" do
      it "sets the :showDefaults param" do
        expect(schema_info.show_defaults.params[:showDefaults]).to be true
        expect(schema_info.show_defaults(false).params[:showDefaults]).to be false
      end
    end

    describe "#include_dynamic" do
      it "sets the :includeDynamic param" do
        expect(schema_info.include_dynamic.params[:includeDynamic]).to be true
        expect(schema_info.include_dynamic(false).params[:includeDynamic]).to be false
      end
    end

    describe "#info" do
      it "returns the relation unaltered" do
        expect(schema_info.info).to eql(schema_info)
      end
    end

    describe "#similarity" do
      it "adds 'similarity' to the path" do
        expect(schema_info.similarity.dataset.path).to eq 'schema/similarity'
      end
    end

    describe "#unique_key" do
      it "adds 'uniquekey' to the path" do
        expect(schema_info.unique_key.dataset.path).to eq 'schema/uniquekey'
      end
    end

    describe "#version" do
      it "adds 'version' to the path" do
        expect(schema_info.version.dataset.path).to eq 'schema/version'
      end
    end

    describe "#schema_name" do
      it "adds 'name' to the path" do
        expect(schema_info.schema_name.dataset.path).to eq 'schema/name'
      end
    end

    describe "#fields" do
      it "adds 'fields' to the path" do
        expect(schema_info.fields.dataset.path).to eq 'schema/fields'
      end
      it "sets the :includeDynamic param" do
        expect(schema_info.fields.params[:includeDynamic]).to be true
        expect(schema_info.fields(dynamic: false).params[:includeDynamic]).to be false
      end
      it "sets the :showDefaults param" do
        expect(schema_info.fields.params[:showDefaults]).to be true
        expect(schema_info.fields(defaults: false).params[:showDefaults]).to be false
      end
    end

    describe "#field" do
      it "adds 'fields/[name]' to the path" do
        expect(schema_info.field(:title).dataset.path).to eq 'schema/fields/title'
      end
      it "sets the :showDefaults param" do
        expect(schema_info.field(:title).params[:showDefaults]).to be true
        expect(schema_info.field(:title, defaults: false).params[:showDefaults]).to be false
      end
    end

    describe "#field_types" do
      it "adds 'fieldtypes' to the path" do
        expect(schema_info.field_types.dataset.path).to eq 'schema/fieldtypes'
      end
      it "sets the :showDefaults param" do
        expect(schema_info.field_types.params[:showDefaults]).to be true
        expect(schema_info.field_types(defaults: false).params[:showDefaults]).to be false
      end
    end

    describe "#field_type" do
      it "adds 'fieldtypes/[type]' to the path" do
        expect(schema_info.field_type(:plong).dataset.path).to eq 'schema/fieldtypes/plong'
      end
      it "sets the :showDefaults param" do
        expect(schema_info.field_type(:plong).params[:showDefaults]).to be true
        expect(schema_info.field_type(:plong, defaults: false).params[:showDefaults]).to be false
      end
    end

    describe "#copy_fields" do
      it "adds 'copyfields' to the path" do
        expect(schema_info.copy_fields.dataset.path).to eq 'schema/copyfields'
      end
      it "sets the 'source.fl' param" do
        expect(schema_info.copy_fields(source_fields: ['foo', 'bar']).params['source.fl']).to eq 'foo,bar'
      end
      it "sets the 'dest.fl' param" do
        expect(schema_info.copy_fields(dest_fields: ['foo', 'bar']).params['dest.fl']).to eq 'foo,bar'
      end
    end

    describe "#dynamic_fields" do
      it "adds 'dynamicfields' to the path" do
        expect(schema_info.dynamic_fields.dataset.path).to eq 'schema/dynamicfields'
      end
      it "sets the :showDefaults param" do
        expect(schema_info.dynamic_fields.params[:showDefaults]).to be true
        expect(schema_info.dynamic_fields(defaults: false).params[:showDefaults]).to be false
      end
    end

    describe "#dynamic_field" do
      it "adds 'dynamicfields/[name]' to the path" do
        expect(schema_info.dynamic_field('*_p').dataset.path).to eq 'schema/dynamicfields/*_p'
      end
      it "sets the :showDefaults param" do
        expect(schema_info.dynamic_field('*_p').params[:showDefaults]).to be true
        expect(schema_info.dynamic_field('*_p', defaults: false).params[:showDefaults]).to be false
      end
    end

  end
end
