module SingleQuote
  class SingleQuotedStringContents
    ESCAPE_REGEXP = Regexp.union([
      /\\[abefnrstv]/,
      /#\{[^}]*\}/,
      /"/,
      /\\\d{3}/,
      /\\x[a-fA-F0-9]{2}/,
      /\\u\d{4}/,
      /\\c\d/,
      /\\C-\d/,
      /\\M-\d?/
    ])

    SINGLE_QUOTE_REGEXP = /\\'/

    SINGLE_QUOTE = "'"

    attr_reader :contents

    def initialize(contents)
      @contents = contents
    end

    def to_double_quoted_string
      contents.gsub(ESCAPE_REGEXP) do |match|
        "\\#{match}"
      end.gsub(SINGLE_QUOTE_REGEXP, SINGLE_QUOTE)
    end
  end
end
