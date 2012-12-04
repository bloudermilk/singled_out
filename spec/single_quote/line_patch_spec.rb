require "spec_helper"

require "single_quote/line_patch"

describe SingleQuote::LinePatch do
  describe "#apply" do
    subject { described_class.new(double, 8, 2, "hello world") }
    let(:source_line) { "replace me, fool" }

    it "replaces the relevant contents of the passed string" do
      subject.apply(source_line).should eq("replace hello world, fool")
    end
  end
end
