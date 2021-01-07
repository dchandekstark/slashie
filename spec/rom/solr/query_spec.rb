module ROM::Solr
  RSpec.describe Query do

    describe ".after" do
      subject { described_class.after(foo: '2021-01-01 12:34:56 +00:00') }

      it { is_expected.to eq ['foo:[2021-01-01T12:34:56Z TO NOW]'] }
    end

    describe ".before" do
      subject { described_class.before(foo: '2021-01-01 12:34:56 +00:00') }

      it { is_expected.to eq ['foo:[* TO 2021-01-01T12:34:56Z]'] }
    end

    describe ".between_dates" do
      subject { described_class.between_dates(foo: ['2021-01-01 12:34:56 +00:00', '2021-01-02 12:34:56 +00:00']) }

      it { is_expected.to eq ['foo:[2021-01-01T12:34:56Z TO 2021-01-02T12:34:56Z]'] }
    end

    describe ".exact_date" do
      subject { described_class.exact_date(foo: '2021-01-01 12:34:56 +00:00') }

      it { is_expected.to eq ['foo:2021\-01\-01T12\:34\:56Z'] }
    end

    describe ".exist" do
      subject { described_class.exist(:foo, :bar) }

      it { is_expected.to contain_exactly('foo:[* TO *]', 'bar:[* TO *]') }
    end

    describe ".join" do

    end

    describe ".not_exist" do
      subject { described_class.not_exist(:foo, :bar) }

      it { is_expected.to contain_exactly('-foo:[* TO *]', '-bar:[* TO *]') }
    end

    describe ".regex" do
      subject { described_class.regex(foo: 'bar') }

      it {is_expected.to eq ['foo:/bar/'] }
    end

    describe ".term" do
      subject { described_class.term(foo: 'bar') }

      it { is_expected.to eq ['{!term f=foo}bar'] }
    end

    describe ".where"

    describe ".where_not"

  end
end
