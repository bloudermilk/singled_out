require "spec_helper"

require "single_quote/single_quoted_string"

describe SingleQuote::SingleQuotedString do
  describe "#new_contents" do
    it "escapes string interpolation"
    it "escapes double quotes"
    it "unescapes single quotes"
    it "escapes newline sequences"
    it "escapes space sequences"
    it "escapes carriage return sequences"
    it "escapes tab sequences"
    it "escapes vertical tab sequences"
    it "escapes formfeed sequences"
    it "escapes backspace sequences"
    it "escapes bell sequences"
    it "escapes escape sequences"
    it "escapes octal character sequences"
    it "escapes hex character sequences"
    it "escapes unicode character sequences"
    it "escapes control sequences"
    it "escapes meta sequences"
    it "escapes meta control sequences"
  end
end
