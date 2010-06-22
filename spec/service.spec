require File.dirname(__FILE__) + "/spec_helper.rb"

describe BBC::Programmes::Version do
  before :each do
    @repo = RDF::Repository.new
    Spira.add_repository(:default, @repo)
  end

  context "getting a Service from the local repository" do
    before :each do
      @repo.load(
        fixture('b005sv69.rdf'),
        :base_uri => 'http://www.bbc.co.uk/programmes/b005sv69.rdf'
      )
      @service = BBC::Programmes::Service.for(
        RDF::URI('http://www.bbc.co.uk/services/bbctwo/england#service')
      )
    end

    it "should have a name property" do
      @service.name.should == 'England'
    end

    it "should have a parent service property" do
      @service.parent.should == BBC::Programmes::Service.for(
        RDF::URI('http://www.bbc.co.uk/services/bbctwo#service')
      )
    end

    it "should have a to_s method that returns the service name" do
      @service.to_s.should == 'England'
    end
  end
end
