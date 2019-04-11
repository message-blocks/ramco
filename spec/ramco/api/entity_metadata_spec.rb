require 'spec_helper'

describe Ramco::API::EntityMetadata do
  subject { Ramco.api_key(RAMCO_KEY) }

  describe "#get_entity_metadata" do
    it "should get entity metadata" do
      VCR.use_cassette('get entity metadata') do
        response = subject.get_entity_metadata({"entity" => "Contact"})
        expect(response).to be_instance_of(Hash)
        expect(response).to have_key "Name"
        expect(response["Name"]).to eq("Contact")
        expect(response).to have_key "PrimaryIdAttribute"
        expect(response["PrimaryIdAttribute"]).to eq("ContactId")        
      end
    end
  end
end
