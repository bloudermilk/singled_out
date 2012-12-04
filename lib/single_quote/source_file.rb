require "ripper"

require "single_quote/source_line"
require "single_quote/token"
require "single_quote/token_sequence"

module SingleQuote
  class SourceFile
    DOUBLE_QUOTE = "\""

    attr_reader :source

    def initialize(source)
      @source = source
    end

    def fixed_source
      source_lines.tap do |source_lines|
        single_quoted_strings.map(&:line_patches).each do |line_patch|
          new_line = line_patch.patch(source_lines[line_patch.row])
          source_lines[line_patch.row] = new_line
        end
      end.join
    end

    def source_lines
      source.lines.to_a
    end

    def single_quoted_strings
      token_sequences.map(&:single_quoted_string).compact
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
