RSpec.describe "Schema API" do

  subject { Solrbee.schema }

  its(:info) { is_expected.to be_a Hash }
  its(:schema_name) { is_expected.to eq 'default-config' }
  its(:version) { is_expected.to eq 1.6 }
  its(:unique_key) { is_expected.to eq 'id' }
  its(:similarity) { is_expected.to be_a Hash }
  its(:fields) { is_expected.to be_a ROM::Solr::SchemaRelation }
  its(:dynamic_fields) { is_expected.to be_a ROM::Solr::SchemaRelation }
  its(:copy_fields) { is_expected.to be_a ROM::Solr::SchemaRelation }
  its(:field_types) { is_expected.to be_a ROM::Solr::SchemaRelation }

  specify {
    expect(subject.field(:id)).to be_a Hash
  }

  specify {
    expect(subject.field_type(:plong)).to be_a Hash
  }

  specify {
    expect(subject.dynamic_field('*_p')).to be_a Hash
  }

end
