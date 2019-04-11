require 'spec_helper'

describe Ramco::API::ClearCache do
  subject { Ramco.api_key(RAMCO_KEY) }

  describe "#clear_cache" do
    it "should clear cache" do
      VCR.use_cassette('clear cache') do
        response = subject.clear_cache
        expect(response).to be_nil
      end
    end
  end
end
