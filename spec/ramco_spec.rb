require 'spec_helper'

describe Ramco do
  it "should have a VERSION constant" do
    expect(Ramco.const_defined?('VERSION')).to be_truthy
  end

  describe "factory methods" do 
    context "with api key" do
      it "should set up a connection" do 
        rc = Ramco.api_key "ABC123"
        expect(rc.connection).to be_instance_of(Ramco::Connection)
        expect(rc.connection.hash).to eq({api_key: "ABC123"})
      end
    end
  end
  describe "#initialize" do
    context "with an api key" do
      it "should set up a connection" do
        rc = Ramco.new({api_key: "ABC123"})
        expect(rc.connection).to be_instance_of(Ramco::Connection)
        expect(rc.connection.hash).to eq({api_key: "ABC123"})
        expect(rc.connection.api_key).to eq("ABC123")
      end
    end

    context "without an access_token" do
      it "should set up a connection" do
        rc = Ramco.new
        expect(rc.connection).to be_instance_of(Ramco::Connection)
      end
    end
  end
end