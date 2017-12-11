require "test_helper"

describe Question do
  let(:question) { Question.new }

  it "must be valid" do
    value(question).must_be :valid?
  end
end
