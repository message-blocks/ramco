require 'spec_helper'

describe Ramco::API::EntityTypes do
  subject { Ramco.api_key(RAMCO_KEY) }

  describe "#get_entity_types" do
    it "should get entity types" do
      VCR.use_cassette('get entity types') do
        response = subject.get_entity_types
        expect(response).to be_instance_of(Hash)  
        expect(response).to have_key "contact"
      end
    end
  end
end