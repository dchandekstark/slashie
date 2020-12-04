module Solrbee
  RSpec.describe Client do

    subject { described_class.new(collection) }
    let(:collection) { 'solrbee' }

    describe "connection"

    describe "request_class"

    describe "request"

    describe "get"

    describe "post"

    describe "cursor"

    describe "reader methods" do
      its(:collection) { is_expected.to eq collection }
      its(:uri) { is_expected.to eq URI("http://localhost:8983/solr/#{collection}") }
    end

    describe "convenience methods" do
      its(:field_names) { is_expected.to include("_nest_path_", "_root_", "_text_", "_version_", "id") }
      its(:field_type_names) {
        is_expected.to include("string", "plong", "pint", "pdate", "boolean",
                               "strings", "plongs", "pints", "pdates", "booleans")
      }
    end

    describe "API methods" do
      its(:schema_name) { is_expected.to eq 'default-config' }
      its(:schema_version) { is_expected.to eq 1.6 }
      its(:unique_key) { is_expected.to eq 'id' }
      its(:schema) { is_expected.to be_a Response }
      its(:fields) { is_expected.to be_a Array }
      its(:field_types) { is_expected.to be_a Array }

      describe "field" do
        let(:field) { subject.field("id") }

        specify {
          expect(field).to be_a Hash
        }
        specify {
          expect(field.name).to eq "id"
        }
      end

      describe "field_type" do
        let(:field_type) { subject.field_type("string") }

        specify {
          expect(field_type).to be_a Hash
        }
        specify {
          expect(field_type.name).to eq "string"
        }
      end

      # def add_field(field)
      #   post('/schema', {"add-field"=>field})
      # end

      # def delete_field(field)
      #   post('/schema', {"delete-field"=>{"name"=>field.name}})
      # end

      # def replace_field(field)
      #   post('/schema', {"replace-field"=>field})
      # end

    # # "real-time get"
    # # Note: Using POST here for simpler params.
    # def get_by_id(*ids)
    #   response = post('/get', params: { id: ids })
    #   response.doc || response.docs
    # end

    # def index(*docs, commit: false)
    #   post('/update/json/docs?commit=%s' % commit, docs)
    # end
    # alias_method :add, :index
    # alias_method :update, :index

    # def delete(*ids)
    #   post('/update', delete: ids)
    # end

    # def query(params)
    #   post('/query', Query.new(params))
    # end
    end
  end
end
