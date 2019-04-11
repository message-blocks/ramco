require 'spec_helper'

describe Ramco::API::Entities do
  subject { Ramco.api_key(RAMCO_KEY) }

  describe "#get_entities" do
    it "should get entities" do
      VCR.use_cassette('get entities') do
        response = subject.get_entities({"entity" => "Contact", "attributes" => "ContactId,FirstName,LastName", "maxresults" => "2"})
        expect(response.length).to eq(2)
        expect(response[0]).to have_key "ContactId"
      end
    end
  end
end
