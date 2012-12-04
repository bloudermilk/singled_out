require "spec_helper"

require "single_quote/line_patch"

describe SingleQuote::LinePatch do
  describe "#patch" do
    subject { described_class.new(double, 2, 4, "hello world") }
    let(:source_line) { mock() }

    it "should return a new SourceLine object" do
      subject.patch(source_line).should be_an_instance_of(SourceLine)
    end
  end
end
