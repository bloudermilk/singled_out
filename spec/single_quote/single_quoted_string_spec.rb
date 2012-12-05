require "spec_helper"

require "single_quote/single_quoted_string"

describe SingleQuote::SingleQuotedString do
  describe "#new_contents" do
    it "unescapes single quotes" do
      contents_token = double("contents_token", contents: "\'")
      subject = described_class.new(double, double, contents_token)
      subject.new_contents.should eq("'")
    end

    context "does not escape" do
      let(:contents_token) { double }
      subject { described_class.new(double, double, contents_token) }

      def should_not_escape(before)
        contents_token.stub(contents: before)
        subject.new_contents.should eq(before)
      end

      specify "actual newlines" do
        should_not_escape("foo\nbar")
      end

      specify "actual tabs" do
        should_not_escape("foo\tbar")
      end
    end

    context "escapes" do
      let(:contents_token) { double }
      subject { described_class.new(double, double, contents_token) }

      def should_escape(before, after)
        contents_token.stub(contents: before)
        subject.new_contents.should eq(after)
      end

      specify "string interpolation" do
        should_escape("\#{foo}", "\\\#{foo}")
      end

      specify "double quotes" do
        should_escape("\"", "\\\"")
      end

      specify "newline sequences" do
        should_escape("\\n", "\\\\n")
      end

      specify "space sequences" do
        should_escape("\\s", "\\\\s")
      end

      specify "carriage return sequences" do
        should_escape("\\r", "\\\\r")
      end

      specify "tab sequences" do
        should_escape("\\t", "\\\\t")
      end

      specify "vertical tab sequences" do
        should_escape("\\v", "\\\\v")
      end

      specify "formfeed sequences" do
        should_escape("\\f", "\\\\f")
      end

      specify "backspace sequences" do
        should_escape("\\b", "\\\\b")
      end

      specify "bell sequences" do
        should_escape("\\a", "\\\\a")
      end

      specify "escape sequences" do
        should_escape("\\e", "\\\\e")
      end

      specify "octal character sequences" do
        should_escape("\\000", "\\\\000")
      end

      specify "hexidecimal character sequences" do
        should_escape("\\xFF", "\\\\xFF")
      end

      specify "unicode character sequences" do
        should_escape("\\u1111", "\\\\u1111")
      end

      specify "control sequences" do
        should_escape("\\c4", "\\\\c4")
        should_escape("\\C-4", "\\\\C-4")
      end

      specify "meta sequences" do
        should_escape("\\M-1", "\\\\M-1")
      end

      specify "meta control sequences" do
        should_escape("\\M-\\C-1", "\\\\M-\\\\C-1")
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

  describe "#new_lines" do
    subject { described_class.new(double, double, contents_token) }

    let(:contents_token) { mock(contents: "hello\nworld") }

    it "splits up #double_quoted_string into lines" do
      subject.new_lines.should eq(%W["hello world"])
    end
  end

  describe "#line_patches" do
    subject { described_class.new(start_token, double, contents_token) }

    let(:start_token) { mock(row: 5, column: 10) }
    let(:contents_token) { mock(contents: "hey mon\nwhat's your story") }

    it "returns an Array of LinePatch objects for each object in #new_lines" do
      subject.should have(2).line_patches
    end

    it "uses the #start_token's #column for the first patch's #column" do
      first_patch = subject.line_patches.first
      first_patch.column.should eq(10)
    end

    it "uses 0 for the #column of all other patches" do
      last_patch = subject.line_patches.last
      last_patch.column.should eq(0)
    end

    it "offsets each patch's #row from the #start_token's #row" do
      first_patch, last_patch = subject.line_patches
      first_patch.row.should eq(5)
      last_patch.row.should eq(6)
    end

    it "sets the #length of each patch to the length of the old string" do
      first_patch, last_patch = subject.line_patches
      first_patch.length.should eq(8)
      last_patch.length.should eq(18)
    end
  end
end
