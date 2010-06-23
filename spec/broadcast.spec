require File.dirname(__FILE__) + "/spec_helper.rb"

describe BBC::Programmes::Broadcast do
  before :each do
    @repo = RDF::Repository.new
    Spira.add_repository(:default, @repo)
  end

  context "getting a Broadcast from the local repository" do
    before :each do
      @repo.load(
        fixture('b005sv69.rdf'),
        :base_uri => 'http://www.bbc.co.uk/programmes/b005sv69.rdf'
      )
      @broadcast = BBC::Programmes::Broadcast.for(
        RDF::URI('http://www.bbc.co.uk/programmes/b005sv69#p002jmsj')
      )
    end

    it "should have a PID property" do
      @broadcast.pid.should == 'p002jmsj'
    end

    it "should have a schedule date property" do
      @broadcast.schedule_date.to_s.should == '2009-03-30'
    end

    it "should have a broadcast_of property" do
      @broadcast.broadcast_of.should be_a BBC::Programmes::Version
    end

    it "should have a 'version' alias property" do
      @broadcast.version.should be_a BBC::Programmes::Version
    end

    it "should have a broadcast_on property with a label" do
      @broadcast.broadcast_on.should be_a BBC::Programmes::Service
      @broadcast.broadcast_on.label.should == 'Northern Ireland (Analogue)'
    end

    it "should have a 'service' alias property" do
      @broadcast.service.should be_a BBC::Programmes::Service
    end

    it "should have a TimeInterval property" do
      @broadcast.time.should be_a BBC::Programmes::TimeInterval
    end

    it "should have an interval start time of 22:20 GMT" do
      @broadcast.time.start.should == DateTime.parse('2009-03-30T22:20:00Z')
    end

    it "should have an interval end time of 23:20 GMT" do
      @broadcast.time.end.should == DateTime.parse('2009-03-30T23:20:00Z')
    end

    it "should have a porxy method to get the broadcast start time" do
      @broadcast.start.should == DateTime.parse('2009-03-30T22:20:00Z')
    end

    it "should have a porxy method to get the broadcast end time" do
      @broadcast.end.should == DateTime.parse('2009-03-30T23:20:00Z')
    end
  end
end
