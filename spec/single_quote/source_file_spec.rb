require "spec_helper"

require "single_quote/source_file"

describe SingleQuote::SourceFile do
  describe "#single_quoted_strings" do
    it "returns an array of SingleQuotedString's"
    it "works with quotes with no contents"
  end

  describe "#token_sequences" do
    subject { SingleQuote::SourceFile.new("") }

    context "when there are no tokens in the source file" do
      before { subject.stub(tokens: Array.new) }

      it "returns an empty array" do
        subject.token_sequences.should be_empty
      end
    end

    context "when there is one token in the source file" do
      before { subject.stub(tokens: Array.new(1)) }

      it "returns an empty array" do
        subject.token_sequences.should be_empty
      end
    end

    context "when there are two tokens in the source file" do
      before { subject.stub(tokens: Array.new(2)) }

      it "returns an array of one sequence" do
        subject.token_sequences.should have(1).item
      end
    end

    context "when there are three or more tokens in the source file" do
      before { subject.stub(tokens: Array.new(3)) }

      it "returns an array of n-1 sequences" do
        subject.token_sequences.should have(2).items
      end
    end
  end
end
