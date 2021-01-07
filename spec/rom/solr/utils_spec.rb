module ROM::Solr
  RSpec.describe Utils do

    describe "#quote" do
      subject { Utils.quote(value) }

      describe "with an unquoted string" do
        let(:value) { "This string is not quoted" }

        it { is_expected.to eq '"This string is not quoted"' }
      end
      describe "with a quoted string" do
        let(:value) { '"This \"string\" is quoted"' }

        it { is_expected.to eq value }
      end
    end

    describe "#quoted?" do
      subject { Utils.quoted?(value) }

      describe "with an unquoted string" do
        let(:value) { "This string is not quoted" }

        it { is_expected.to be false }
      end
      describe "with a quoted string" do
        let(:value) { '"This string is quoted"' }

        it { is_expected.to be true }
      end
    end

    describe "#regex" do
      subject { Utils.regex(value) }

      describe "when enclosed by slashes" do
        let(:value) { '/foo\/bar/' }

        it { is_expected.to eq '/foo\/bar/' }
      end

      describe "when not enclosed by slashes" do
        let(:value) { 'foo/bar: spam+eggs' }

        it { is_expected.to eq '/foo\/bar: spam+eggs/' }
      end
    end

    describe "#escape" do
      subject { Utils.escape(value) }

      describe "with special characters" do
        let(:value) { 'I am (full) of +"stuff" && things:{like} this!' }

        it { is_expected.to eq 'I\ am\ \(full\)\ of\ \+\"stuff\"\ \&\&\ things\:\{like\}\ this\!' }
      end

      describe "with a quoted string" do
        let(:value) { '"This string is quoted"' }

        it { is_expected.to eq value }
      end
    end

    describe "#solr_date" do
      subject { Utils.solr_date(value) }

      describe "with a Date" do
        let(:value) { Date.new(2021, 01, 01) }

        it { is_expected.to match /2021-01-01T\d{2}:00:00Z/ }
      end

      describe "with a DateTime" do
        let(:value) { DateTime.new(2021, 01, 01, 12, 45, 32, '+00:00') }

        it { is_expected.to eq '2021-01-01T12:45:32Z' }
      end

      describe "with a Time" do
        let(:value) { Time.new(2021, 01, 01, 12, 45, 32, '+00:00') }

        it { is_expected.to eq '2021-01-01T12:45:32Z' }
      end

      describe "with a String" do
        let(:value) { '2021-01-01 12:45:32 +00:00' }

        it { is_expected.to eq '2021-01-01T12:45:32Z' }
      end
    end

  end
end
