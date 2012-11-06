require "ripper"

require "single_quote/token"
require "single_quote/token_sequence"

module SingleQuote
  class SourceFile
    def initialize(source)
      @source = source
    end

    def fix!
      # For each
    end

    def single_quoted_strings
      token_sequences.map(&:single_quoted_string).flatten
    end

    def token_sequences
      tokens[0..-2].each_with_index.map do |token, index|
        next_token = tokens[index.next]
        next_next_token = tokens[index.next.next]

        TokenSequence.new(token, next_token, next_next_token)
      end
    end

    def tokens
      Ripper.lex(source).map do |raw_token|
        Token.new(*raw_token)
      end
    end
  end
end
