module ROM::Solr
  RSpec.describe DocumentRepo do

    let(:document_repo) { described_class.new(container) }

    let(:uri) { 'http://localhost:8983/solr/solrbee' }

    let(:container) do
      ROM.container(:solr, uri: uri) do |config|
        config.register_relation(DocumentsRelation)
      end
    end

    let(:id) { 'de38d600-b612-4858-9395-c7ffd55a451d' }

    let(:doc) { {id: id, title: "A Foggy Day"} }

    subject { document_repo }

    describe "#find" do
      before do
        Net::HTTP.post(
          URI("#{uri}/update/json/docs?commit=true"),
          JSON.dump(doc),
          'Content-Type'=>'application/json'
        )
      end

      after do
        Net::HTTP.post(
          URI("#{uri}/update?commit=true"),
          JSON.dump({delete: {query: '*:*'}}),
          'Content-Type'=>'application/json'
        )
      end

      it "retrieves the document" do
        expect(subject.find(id)[:id]).to eq(id)
      end
    end

    its(:search) { is_expected.to be_a DocumentsRelation }

    describe "#all" do
      it "sets the :q param to select all documents" do
        expect(subject.all.params[:q]).to eq '*:*'
      end
    end

    describe "#create"

    describe "#update"

    describe "#delete"

    describe "#delete_by_query" do

    end

    describe "#delete_all" do

    end

  end
end
