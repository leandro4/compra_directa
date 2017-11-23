require "test_helper"

describe ApiToken do
  let(:api_token) { ApiToken.new }

  it "must be valid" do
    value(api_token).must_be :valid?
  end
end
