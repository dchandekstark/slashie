module Solrbee
  RSpec.describe Client do

    its(:connection) { is_expected.to be_a Net::HTTP }
    its(:cursor) { is_expected.to be_a Cursor }

    describe "request"

    describe "reader methods" do
      its(:uri) { is_expected.to eq URI("http://localhost:8983/solr/solrbee") }
    end

    describe "convenience methods" do
      its(:field_names) { is_expected.to include("_nest_path_", "_root_", "_text_", "_version_", "id") }
      its(:field_type_names) {
        is_expected.to include("string", "plong", "pint", "pdate", "boolean",
                               "strings", "plongs", "pints", "pdates", "booleans")
      }
    end

    describe "API methods" do
      its(:ping) { is_expected.to eq 'OK' }
      its(:schema_name) { is_expected.to eq 'default-config' }
      its(:schema_version) { is_expected.to eq 1.6 }
      its(:unique_key) { is_expected.to eq 'id' }
      its(:schema) { is_expected.to be_a Hash }
      its(:fields) { is_expected.to be_a Array }
      its(:field_types) { is_expected.to be_a Array }

      describe "field" do
        let(:field) { subject.field(name: "id") }

        specify {
          expect(field).to be_a Hash
        }
        specify {
          expect(field['name']).to eq "id"
        }
      end

      describe "field_type" do
        let(:field_type) { subject.field_type(name: "string") }

        specify {
          expect(field_type).to be_a Hash
        }
        specify {
          expect(field_type['name']).to eq "string"
        }
      end

      # def add_field(field)

      # def delete_field(field)

      # def replace_field(field)

      # def get_by_id(*ids)

      # def index(*docs, **params)

      # alias_method :add, :index

      # alias_method :update, :index

      # def delete(*ids)

      # def query(params)

    end
  end
end
