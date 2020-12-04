RSpec.describe Solrbee do
  it "has a version number" do
    expect(Solrbee::VERSION).not_to be nil
  end

  its(:solr_url) { is_expected.to eq 'http://localhost:8983/solr' }
end
