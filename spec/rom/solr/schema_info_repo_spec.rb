module ROM::Solr
  RSpec.describe SchemaInfoRepo do

    let(:schema_info) { described_class.new(container) }

    let(:container) do
      ROM.container(:solr, uri: 'http://localhost:8983/solr/solrbee') do |config|
        config.register_relation(SchemaInfoRelation)
      end
    end

    subject { schema_info }

    its(:copy_fields) { is_expected.to be_a Array }
    its(:dynamic_fields) { is_expected.to be_a Array }
    its(:field_types) { is_expected.to be_a Array }
    its(:fields) { is_expected.to be_a Array }
    its(:info) { is_expected.to be_a Hash }
    its(:schema_name) { is_expected.to eq 'default-config' }
    its(:similarity) { is_expected.to be_a Hash }
    its(:unique_key) { is_expected.to eq 'id' }
    its(:version) { is_expected.to eq 1.6 }

    describe "field" do
      subject { schema_info.field('id') }
      it { is_expected.to be_a Hash }
    end

    describe "field_type" do
      subject { schema_info.field_type('plong') }
      it { is_expected.to be_a Hash }
    end

    describe "dynamic_field" do
      subject { schema_info.dynamic_field('*_p') }
      it { is_expected.to be_a Hash }
    end

  end
end
