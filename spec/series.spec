require File.dirname(__FILE__) + "/spec_helper.rb"

describe BBC::Programmes::Series do
  before :each do
    @repo = RDF::Repository.new
    Spira.add_repository(:default, @repo)
  end

  context "fetching a Series from the website" do
    before :each do
      mock_http('www.bbc.co.uk', 'b00jnwm0.rdf')
      @series = BBC::Programmes::Series.fetch('b00jnwm0')
    end

    it "should have a type URI defined" do
      @series.type.should == RDF::URI('http://purl.org/ontology/po/Series')
    end

    it "should have a correct URI" do
      @series.subject.should == RDF::URI('http://www.bbc.co.uk/programmes/b00jnwm0#programme')
    end

    it "should have a programme indentifier" do
      @series.pid.should == 'b00jnwm0'
    end

    it "should have the title 'Series 1'" do
      @series.title.should == 'Series 1'
    end

    it "should have a short synopsis" do
      @series.short_synopsis.should =~ /^Critically acclaimed crime drama series telling the story/
    end

    it "should have a medium synopsis" do
      @series.medium_synopsis.should =~ /^Critically acclaimed crime drama series telling the story/
    end

    it "should have no long synopsis" do
      @series.long_synopsis.should be_nil
    end

    it "should have an image" do
      @series.image.should be_nil
    end

    it "should have a position of 1"
    #  @series.position.should == 1
    #end

    it "should have 13 episodes" do
      @series.episodes.count.should == 13
    end

    it "should have episode of type Episode" do
      @series.episodes.first.class.should == BBC::Programmes::Episode
    end
  end

  context "getting a Series from the local repository" do
    before :each do
      @repo.load(
        fixture('b00jnwm0.rdf'),
        :base_uri => 'http://www.bbc.co.uk/programmes/b00jnwm0.rdf'
      )
      @series = BBC::Programmes::Series.for('b00jnwm0')
    end

    it "should have the title 'Series 1'" do
      @series.title.should == 'Series 1'
    end
  end

end
