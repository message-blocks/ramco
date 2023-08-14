require 'spec_helper'

describe Ramco::Connection do
  context "with an api_token" do
    subject { Ramco::Connection.new({api_key: RAMCO_KEY}) }

    describe "#initialize" do
      it "should set an instance variable for api key" do
        expect(subject.hash).to eq({api_key: RAMCO_KEY})
        expect(subject.api_key).to eq(RAMCO_KEY)
      end
    end

    describe "a valid authorized request" do
      let(:response) do
        VCR.use_cassette('authorized_request') do
          subject.post do |req|
            req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
            req.body = {
              "key" => subject.api_key,
              "operation" => "GetEntity",
              "entity" => "Contact",
              "guid" => "6868642f-0144-e811-9c17-00155d10120d",
              "attributes" => "ContactId,FirstName,LastName"
            }.map{|k,v| "#{k}=#{v}"}.join("&")
          end
        end
      end

      it "should return 200" do
        expect(response.status).to eq(200)
      end

      it "should parse the json response" do
        expect(response.body).to_not be_nil
      end
    end
  end

  context "without an api key" do
    subject { Ramco::Connection.new }

    describe "#initialize" do
      it "should not set an instance variable for api key" do
        expect(subject.hash).to eq({})
      end
    end

    describe "any request" do
      let(:response) do
        VCR.use_cassette('unauthorized_request') do
          subject.post
        end
      end
      it "should raise error" do
        expect {response}.to raise_error(Ramco::BadRequest)
      end
    end
  end
end
