require "spec_helper"

require "single_quote/single_quoted_string_contents"

describe SingleQuote::SingleQuotedStringContents do
  subject { described_class.new(contents) }

  let(:contents) { double }

  describe "#to_double_quoted_string" do
    context "when there are single quotes in the contents" do
      let(:contents) { "hello\\'s world" }

      it "unescapes them" do
        subject.to_double_quoted_string.should eq("hello's world")
      end
    end

    context "when there are tabs in the contents" do
      let(:contents) { "\t" }

      it "does not escape them" do
        subject.to_double_quoted_string.should eq("\t")
      end
    end

    context "when there are newlines in the contents" do
      let(:contents) { "\n" }

      it "does not escape them" do
        subject.to_double_quoted_string.should eq("\n")
      end
    end

    context "when there are interpolated strings in the contents" do
      let(:contents) { "\#{foo}" }

      it "escapes them" do
        subject.to_double_quoted_string.should eq("\\\#{foo}")
      end
    end

    context "when there are double quoted strings in the contents" do
      let(:contents) { "\"hey\"" }

      it "escapes them" do
        subject.to_double_quoted_string.should eq("\\\"hey\\\"")
      end
    end

    context "when there are lettered escape sequences in the contents" do
      let(:contents) { "\\a\\b\\e\\f\\n\\r\\s\\t\\v" }

      it "escapes them" do
        subject.to_double_quoted_string.should eq("\\\\a\\\\b\\\\e\\\\f\\\\n\\\\r\\\\s\\\\t\\\\v")
      end
    end

    context "when there are numerical escape sequences in the contents" do
      let(:contents) { "\\000\\xFF\\u1111\\c4\\C-4\\M-1\\M-\\C-1" }

      it "escapes them" do
        subject.to_double_quoted_string.should eq("\\\\000\\\\xFF\\\\u1111\\\\c4\\\\C-4\\\\M-1\\\\M-\\\\C-1")
      end
    end
  end
end
