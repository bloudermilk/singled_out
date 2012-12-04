module SingleQuote
  class SingleQuotedString
    attr_reader :start_token, :contents_token, :end_token

    def initialize(start_token, end_token, contents_token = nil)
      @start_token = start_token
      @end_token = end_token
      @contents_token = contents_token
    end

    def contents
      contents_token ? contents_token.contents : ""
    end

    def new_contents
      contents.dump[1..-2]
    end

    def double_quoted_string
      "\"#{new_contents}\""
    end

    def patch_lines
      double_quoted_string.lines.map do |contents|
        PatchLine.new()
      end
    end
  end
end
