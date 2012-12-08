require "ripper"

require "single_quote/single_quoted_string_contents"
require "single_quote/token"

module SingleQuote
  class Program
    DOUBLE_QUOTE = "\""
    DOUBLE_QUOTED_SYMBOL = ":\""

    attr_reader :source

    def initialize(source)
      @source = source
    end

    def patched_source
      @patched_source ||= tokens.each_with_index.map do |token, index|
        last_token = tokens[index - 1]

        if token.single_quoted_string_start? || token.single_quoted_string_end?
          DOUBLE_QUOTE
        elsif token.single_quoted_symbol_start?
          DOUBLE_QUOTED_SYMBOL
        elsif token.string_contents? && last_token.single_quoted_string_start?
          SingleQuotedStringContents.new(token.contents).to_double_quoted_string
        else
          token.contents
        end
      end.join
    end

    def changes?
      source != patched_source
    end

    private

    def tokens
      @tokens ||= raw_tokens.map do |position, type, contents|
        Token.new(type, contents)
      end
    end

    def raw_tokens
      Ripper.lex(source)
    end
  end
end
