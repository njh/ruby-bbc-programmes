require File.dirname(__FILE__) + "/spec_helper.rb"

describe BBC::Programmes::Version do
  before :each do
    @repo = RDF::Repository.new
    Spira.add_repository(:default, @repo)
  end

  context "fetching a Version from the website" do
    before :each do
      mock_http('www.bbc.co.uk', 'b005sv69.rdf')
      @version = BBC::Programmes::Version.fetch('b005sv69')
    end

    it "should have a type URI defined" do
      @version.type.should == RDF::URI('http://purl.org/ontology/po/Version')
    end

    it "should have a correct URI" do
      @version.subject.should == RDF::URI('http://www.bbc.co.uk/programmes/b005sv69#programme')
    end

    it "should have a programme indentifier" do
      @version.pid.should == 'b005sv69'
    end

    it "should have an aspect ratio of 16:9" do
      @version.aspect_ratio.should == '16:9'
    end

    it "should have Stereo sound" do
      @version.sound_format.should == 'Stereo'
    end

    it "should have a duration of 1 hour" do
      @version.duration.should == 3600
    end

    it "should have 6 broadcasts" do
      @version.broadcasts.count.should == 6
    end

    it "should have a broadcast of type Broadcast" do
      @version.broadcasts.first.should be_a BBC::Programmes::Broadcast
    end

    it "should have a time interval property" do
      @version.time.should be_a BBC::Programmes::TimeInterval
    end

    it "should be on a timeline" do
      @version.timeline.should be_a BBC::Programmes::TimeLine
    end

    it "should have multiple intervals" do
      @version.intervals.should be_an Array
    end

    it "should have a time interval of type TimeInterval" do
      @version.intervals.first.should be_a BBC::Programmes::TimeInterval
    end

    it "should have multiple segments" do
      @version.segments.should be_an Array
    end

    it "should have a segment of type Segment" do
      @version.segments.first.should be_a BBC::Programmes::Segment
    end

    it "should have a segment with a label" do
      @version.segments.first.label.should_not be_nil
    end
  end

  context "getting a Version from the local repository" do
    before :each do
      @repo.load(
        fixture('b005sv69.rdf'),
        :base_uri => 'http://www.bbc.co.uk/programmes/b005sv69.rdf'
      )
      @version = BBC::Programmes::Version.for('b005sv69')
    end

    it "should have a duration of an hour" do
      @version.duration.should == 3600
    end
  end

end
