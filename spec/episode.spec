require File.dirname(__FILE__) + "/spec_helper.rb"

describe BBC::Programmes::Episode do
  before :each do
    @repo = RDF::Repository.new
    Spira.add_repository(:default, @repo)
  end

  context "fetching a Episode from the website" do
    before :each do
      mock_http('www.bbc.co.uk', 'b00jnwnv.rdf')
      @episode = BBC::Programmes::Episode.fetch('b00jnwnv')
    end

    it "should have a type URI defined" do
      @episode.type.should == RDF::URI('http://purl.org/ontology/po/Episode')
    end

    it "should have a correct URI" do
      @episode.subject.should == RDF::URI('http://www.bbc.co.uk/programmes/b00jnwnv#programme')
    end

    it "should have a programme indentifier" do
      @episode.pid.should == 'b00jnwnv'
    end

    it "should have the title 'The Target'" do
      @episode.title.should == 'The Target'
    end

    it "should have a short synopsis" do
      @episode.short_synopsis.should =~ /^During the murder trial of a mid-level dealer/
    end

    it "should have a medium synopsis" do
      @episode.medium_synopsis.should =~ /^Critically acclaimed crime drama series. During the trial/
    end

    it "should have no long synopsis" do
      @episode.long_synopsis.should =~ /^During the trial of D'Angelo Barksdale/
    end

    it "should have an image" do
      @episode.image.should be_nil
    end

    it "should have a master brand" do
      @episode.masterbrand.should == RDF::URI('http://www.bbc.co.uk/bbctwo#service')
    end

    it "should have a position of 1" do
      @episode.position.should == 1
    end

    it "should have one version" do
      @episode.versions.count.should == 1
    end

    it "should have a first version of type Version" do
      @episode.versions.first.class.should == BBC::Programmes::Version
    end
  end

  context "getting a Episode from the local repository" do
    before :each do
      @repo.load(
        fixture('b00jnwnv.rdf'),
        :base_uri => 'http://www.bbc.co.uk/programmes/b00jnwnv.rdf'
      )
      @episode = BBC::Programmes::Episode.for('b00jnwnv')
    end

    it "should have the title 'The Target'" do
      @episode.title.should == 'The Target'
    end
  end

end
