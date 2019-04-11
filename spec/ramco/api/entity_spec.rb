require 'spec_helper'

describe Ramco::API::Entity do
  subject { Ramco.api_key(RAMCO_KEY) }

  describe "#get_entity" do
    it "should get entity" do
      VCR.use_cassette('get entity') do
        response = subject.get_entity({"entity" => "Contact", "guid" => "6868642f-0144-e811-9c17-00155d10120d", "attributes" => "ContactId,FirstName,LastName"})
        expect(response).to be_instance_of(Hash)  
        expect(response).to have_key "ContactId"
        expect(response["ContactId"]).to eq("6868642f-0144-e811-9c17-00155d10120d")
      end
    end
  end
end
