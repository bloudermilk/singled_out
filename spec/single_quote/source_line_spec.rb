require "spec_helper"

require "single_quote/source_line"

describe SingleQuote::SourceLine do
  describe ".from_string" do
    it "returns a SourceLine for each line in the passed string" do
      lines = described_class.from_string("foo\nbar")
      lines.should be_an_instance_of(Array)
      lines.first.should be_an_instance_of(described_class)
      lines.last.should be_an_instance_of(described_class)
    end
  end
end
