require "spec_helper"

require "single_quote/single_quoted_string"

describe SingleQuote::SingleQuotedString do
  describe "#new_contents" do
    it "unescapes single quotes" do
      contents_token = double("contents_token", contents: "\'")
      subject = described_class.new(double, double, contents_token)
      subject.new_contents.should eq("'")
    end

    context "escapes" do
      let(:contents_token) { double("contents_token") }
      subject { described_class.new(double, double, contents_token) }

      def should_escape(before, after)
        contents_token.stub(contents: before)
        subject.new_contents.should eq(after)
      end

      specify "string interpolation" do
        should_escape('#{foo}', '\#{foo}')
      end

      specify "double quotes" do
        should_escape('"', '\"')
      end

      specify "newline sequences" do
        should_escape('\n', '\\\n')
      end

      specify "space sequences" do
        should_escape('\s', '\\\s')
      end

      specify "carriage return sequences" do
        should_escape('\r', '\\\r')
      end

      specify "tab sequences" do
        should_escape('\t', '\\\t')
      end

      specify "vertical tab sequences" do
        should_escape('\v', '\\\v')
      end

      specify "formfeed sequences" do
        should_escape('\f', '\\\f')
      end

      specify "backspace sequences" do
        should_escape('\b', '\\\b')
      end

      specify "bell sequences" do
        should_escape('\a', '\\\a')
      end

      specify "escape sequences" do
        should_escape('\e', '\\\e')
      end

      specify "octal character sequences" do
        should_escape('\000', '\\\000')
      end

      specify "hexidecimal character sequences" do
        should_escape('\xFF', '\\\xFF')
      end

      specify "unicode character sequences" do
        should_escape('\u1111', '\\\u1111')
      end

      specify "control sequences" do
        should_escape('\c4', '\\\c4')
        should_escape('\C4', '\\\C4')
      end

      specify "meta sequences" do
        should_escape('\M-1', '\\\M-1')
      end

      specify "meta control sequences" do
        should_escape('\M-\C-1', '\\\M-\\\C-1')
      end
    end
  end

  describe "#double_quoted_string" do
    subject { described_class.new(double, double, contents_token) }
    let(:contents_token) { mock(contents: "foo") }

    it "returns the new_contents string wrapped in double quotes" do
      subject.double_quoted_string.should eq("\"foo\"")
    end
  end
end
