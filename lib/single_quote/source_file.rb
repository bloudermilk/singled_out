require "ripper"

require "single_quote/token"
require "single_quote/token_sequence"

module SingleQuote
  class SourceFile
    DOUBLE_QUOTE = "\""
    TRAILING_NEWLINE_REGEXP = /\n+\z/

    attr_reader :source

    def initialize(source)
      @source = source
    end

    def fixed_source
      fixed_source_lines.join($/).tap do |fixed_source|
        fixed_source << trailing_newlines if trailing_newlines?
      end
    end

    def fixed_source_lines
      source_lines.tap do |source_lines|
        line_patches.each do |line_patch|
          new_line = line_patch.apply(source_lines[line_patch.row - 1])
          source_lines[line_patch.row - 1] = new_line
        end
      end
    end

    def source_lines
      source.split($/)
    end

    def line_patches
      single_quoted_strings.map(&:line_patches).flatten
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

    def trailing_newlines?
      !!trailing_newlines
    end

    def trailing_newlines
      source[TRAILNG_NEWLINE_REGEXP, 0]
    end
  end
end
