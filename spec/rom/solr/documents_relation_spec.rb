module ROM::Solr
  RSpec.describe DocumentsRelation do

    let(:container) do
      ROM.container(:solr, uri: 'http://localhost:8983/solr/solrbee') do |config|
	config.register_relation(DocumentsRelation)
      end
    end

    let(:documents) { container.relations[:documents] }

    describe "#by_unique_key" do
      it "adds unique key query" do
        expect(documents.by_unique_key("09e59b1c-2d0e-49be-adbd-af9b9a3b453a").dataset.params)
          .to include(q: 'id:09e59b1c-2d0e-49be-adbd-af9b9a3b453a')
      end
    end

    describe "#q" do
      it "adds :q param" do
        expect(documents.q('*:*').dataset.params).to include(q: '*:*')
      end
    end

    describe "#rows" do
      it "adds :rows param" do
        expect(documents.rows(10).dataset.params).to include(rows: 10)
        expect(documents.limit(10).dataset.params).to include(rows: 10)
      end
    end

    describe "#fq" do
      it "adds :fq param" do
        expect(documents.fq('foo:bar', 'bim:bam').dataset.params).to include(fq: ['foo:bar', 'bim:bam'])
        expect(documents.filter('foo:bar', 'bim:bam').dataset.params).to include(fq: ['foo:bar', 'bim:bam'])
      end
    end

    describe "#fl" do
      it "adds :fl param" do
        expect(documents.fl('id', 'title').dataset.params).to include(fl: 'id,title')
        expect(documents.fields('id', 'title').dataset.params).to include(fl: 'id,title')
      end
    end

    describe "#cache" do
      it "adds :cache param" do
        expect(documents.cache.dataset.params).to include(cache: true)
        expect(documents.cache(false).dataset.params).to include(cache: false)
      end
    end

    describe "#segment_terminate_early" do
      it "adds :segmentTerminateEarly param" do
        expect(documents.segment_terminate_early.dataset.params).to include(segmentTerminateEarly: true)
        expect(documents.segment_terminate_early(false).dataset.params).to include(segmentTerminateEarly: false)
      end
    end

    describe "#time_allowed" do
      it "adds :timeAllowed param" do
        expect(documents.time_allowed(1000).dataset.params).to include(timeAllowed: 1000)
      end
    end

    describe "#explain_other" do
      it "adds :explainOther param" do
        expect(documents.explain_other('foo:bar').dataset.params).to include(explainOther: 'foo:bar')
      end
    end

    describe "#omit_header" do
      it "adds :omitHeader param" do
        expect(documents.omit_header.dataset.params).to include(omitHeader: true)
        expect(documents.omit_header(false).dataset.params).to include(omitHeader: false)
      end
    end

    describe "#start" do
      it "adds :start param" do
        expect(documents.start(100).dataset.params).to include(start: 100)
      end
    end

    describe "#sort" do
      it "adds :sort param" do
        expect(documents.sort('title ASC', 'id ASC').dataset.params).to include(sort: 'title ASC,id ASC')
      end
    end

    describe "#def_type" do
      it "adds :defType param" do
        expect(documents.def_type(:dismax).dataset.params).to include(defType: 'dismax')
      end
    end

    describe "#debug" do
      it "adds :debug param" do
        expect(documents.debug(:query).dataset.params).to include(debug: 'query')
      end
    end

    describe "#echo_params" do
      it "adds :echoParams param" do
        expect(documents.echo_params('all').dataset.params).to include(echoParams: 'all')
      end
    end

    describe "#min_exact_count" do
      it "adds :minExactCount param" do
        expect(documents.min_exact_count(1).dataset.params).to include(minExactCount: 1)
      end
    end

    describe "#all" do
      it "adds a 'select all' query" do
        expect(documents.all.dataset.params).to include(q: '*:*')
      end
    end

    describe "#count"

    describe "#commit" do
      it "adds :commit param" do
        expect(documents.commit.dataset.params).to include(commit: true)
      end
    end

    describe "#commit_within" do
      it "adds :commitWithin param" do
        expect(documents.commit_within(1000).dataset.params).to include(commitWithin: 1000)
      end
    end

    describe "#overwrite" do
      it "adds :overwrite param" do
        expect(documents.overwrite.dataset.params).to include(overwrite: true)
        expect(documents.overwrite(false).dataset.params).to include(overwrite: false)
      end
    end

    describe "#expunge_deletes" do
      it "adds :expungeDeletes param" do
        expect(documents.expunge_deletes.dataset.params).to include(expungeDeletes: true)
        expect(documents.expunge_deletes(false).dataset.params).to include(expungeDeletes: false)
      end
    end

    describe "#delete_by_query"

    describe "#delete"

    describe "#insert"

    describe "#update"

  end
end
