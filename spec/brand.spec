require File.dirname(__FILE__) + "/spec_helper.rb"

describe BBC::Programmes::Brand do
  before :each do
    @repo = RDF::Repository.new
    Spira.add_repository(:default, @repo)
  end

  context "fetching a Brand from the website" do
    before :each do
      mock_http('www.bbc.co.uk', 'b00jnwlc.rdf')
      @brand = BBC::Programmes::Brand.fetch('b00jnwlc')
    end

    it "should have a type URI defined" do
      @brand.type.should == RDF::URI('http://purl.org/ontology/po/Brand')
    end

    it "should have a correct URI" do
      @brand.subject.should == RDF::URI('http://www.bbc.co.uk/programmes/b00jnwlc#programme')
    end

    it "should have a programme indentifier" do
      @brand.pid.should == 'b00jnwlc'
    end

    it "should have the title 'The Wire'" do
      @brand.title.should == 'The Wire'
    end

    it "should have a short synopsis" do
      @brand.short_synopsis.should =~ /^Critically acclaimed American crime drama/
    end

    it "should have a medium synopsis" do
      @brand.medium_synopsis.should =~ /^Critically acclaimed American crime drama/
    end

    it "should have no long synopsis" do
      @brand.long_synopsis.should be_nil
    end

    it "should have an image" do
      @brand.image.should == RDF::URI('http://www.bbc.co.uk/iplayer/images/progbrand/b00jnwlc_512_288.jpg')
    end

    it "should have a master brand" do
      @brand.masterbrand.should == RDF::URI('http://www.bbc.co.uk/bbctwo#service')
    end

    it "should have five series objects" do
      @brand.series.count.should == 5
    end

    it "should have series of type Series" do
      @brand.series.first.should be_a BBC::Programmes::Series
    end
  end

  context "getting a Brand from the local repository" do
    before :each do
      @repo.load(
        fixture('b00jnwlc.rdf'),
        :base_uri => 'http://www.bbc.co.uk/programmes/b00jnwlc.rdf'
      )
      @brand = BBC::Programmes::Brand.for('b00jnwlc')
    end

    it "should have the title 'The Wire'" do
      @brand.title.should == 'The Wire'
    end
  end

end
