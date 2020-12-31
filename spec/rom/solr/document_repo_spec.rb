module ROM::Solr
  RSpec.describe DocumentRepo do

    let(:document_repo) { described_class.new(container) }

    let(:container) do
      ROM.container(:solr, uri: 'http://localhost:8983/solr/solrbee') do |config|
        config.register_relation(DocumentsRelation)
      end
    end

    subject { document_repo }

    describe "#find"

    describe "#search"

    describe "#all"

    describe "#create"

    describe "#update"

    describe "#delete"

    describe "#delete_by_query"

    describe "#delete_all"

  end
end
