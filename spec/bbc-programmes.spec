require File.dirname(__FILE__) + "/spec_helper.rb"

describe BBC::Programmes do
  before :each do
    @repo = RDF::Repository.new
    Spira.add_repository(:default, @repo)
  end

  context "performing an HTTP get for a URI" do
    before :each do
      mock_http('www.bbc.co.uk', 'b00jnwlc.rdf')
      @uri = RDF::URI('http://www.bbc.co.uk/programmes/b00jnwlc#programme')
      @graph = BBC::Programmes.http_get_graph(@uri)
    end

    it "should return an object of type RDF::Graph" do
      @graph.class.should == RDF::Graph
    end

    it "should return a graph with more than 10 statements" do
      @graph.size.should > 10
    end

    it "should return multiple statements about the URI looked up" do
      @graph.query([@uri, nil, nil]).count.should > 2
    end

    it "should return a triple stating that the programme is of type Brand" do
      @graph.should have_triple([@uri, RDF.type, RDF::PO.Brand])
    end
  end

  context "searching for a keyword" do
    before :each do
      mock_http('www.bbc.co.uk', 'the_wire.rdf')
      @programmes = BBC::Programmes.search("The Wire")
    end

    it "should return an array" do
      @programmes.class.should == Array
    end

    it "should have three items in the array" do
      @programmes.size.should == 3
    end

    it "should have items of type Programme in the array" do
      @programmes.first.class.should == BBC::Programmes::Programme
    end
  end

  context "fetching an episode" do
    before :each do
      mock_http('www.bbc.co.uk', 'b00jnwnv.rdf')
      @episode = BBC::Programmes.fetch('b00jnwnv#programme')
    end

    it "should have a type URI defined" do
      @episode.type.should == RDF::URI('http://purl.org/ontology/po/Episode')
    end

    it "should have a correct URI" do
      @episode.subject.should == RDF::URI('http://www.bbc.co.uk/programmes/b00jnwnv#programme')
    end

    it "should have the title 'The Target'" do
      @episode.title.should == 'The Target'
    end
  end

end
