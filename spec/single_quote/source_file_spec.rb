require "spec_helper"

require "single_quote/source_file"

describe SingleQuote::SourceFile do
  subject { described_class.new(source) }

  describe "#fixed_source" do
    context "with a basic string" do
      let(:source) { "'hello'" }

      it "replaces double quotes with single quotes" do
        subject.fixed_source.should eq('"hello"')
      end
    end

    context "when a string contains some escaped characters" do
      let(:source) { '\'hello\nworld\'' }

      it "replaces the string" do
        subject.fixed_source.should eq('"hello\\\nworld"')
      end
    end

    context "when a string spans multiple lines" do
      let(:source) { "puts 'foo hello\nbar baz'" }

      it "replaces the string" do
        subject.fixed_source.should eq("puts \"foo hello\nbar baz\"")
      end
    end
  end

  describe "#single_quoted_strings" do
    let(:source) { "'foo' + ''" }

    it "returns all the single quoted string" do
      subject.single_quoted_strings.should have(2).items
    end

    it "returns an array of SingleQuotedString's" do
      subject.single_quoted_strings.each do |item|
        item.should be_an_instance_of(SingleQuote::SingleQuotedString)
      end
    end
  end

  describe "#tokens" do
    let(:source) { "'" }

    it "returns an array of tokens" do
      subject.tokens.should have(1).item
      subject.tokens.first.should be_an_instance_of(SingleQuote::Token)
    end
  end

  describe "#token_sequences" do
    let(:source) { "" }

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

  describe "#source_lines" do
    subject { described_class.new("'hello\nworld'") }

    it "returns an array of String objects for each line of #source" do
      subject.source_lines.should eq(%W['hello world'])
    end
  end
end
