require 'spec_helper'

describe Ramco::API::Entity do
  subject { Ramco.api_key(RAMCO_KEY) }

  describe "#get_entity" do
    it "should get entity" do
      VCR.use_cassette('get entity') do
        response = subject.get_entity({"entity" => "Contact", "Guid" => "6868642f-0144-e811-9c17-00155d10120d", "attributes" => "ContactId,FirstName,LastName"})
        expect(response).to be_instance_of(Hash)
        expect(response).to have_key "ContactId"
        expect(response["ContactId"]).to eq("6868642f-0144-e811-9c17-00155d10120d")
      end
    end
  end

  describe "#update_entity" do
    it "should update an entity" do
      VCR.use_cassette('update entity') do
        response = subject.update_entity({"entity" => "Contact", "Guid" => "6868642f-0144-e811-9c17-00155d10120d", "AttributeValues" => "FirstName=#Jane#,LastName=#Doe#"})
        expect(response).to be(nil)
      end
    end
  end

  describe "#create_entity" do
    it "should create an entity" do
      VCR.use_cassette('create entity') do
        response = subject.create_entity({"entity" => "Contact", "AttributeValues" => "FirstName=#Jane#,LastName=#Doe#"})
        expect(response).to eq("efe48f36-6e3e-6576-666f-b8c9bf6ccaf3")
      end
    end
  end
end
