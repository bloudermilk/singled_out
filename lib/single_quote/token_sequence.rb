require "single_quote/single_quoted_string"

# A sequence of two or three tokens that may or may not contain a single quoted
# string
module SingleQuote
  class TokenSequence
    attr_reader :first_token, :second_token, :third_token

    def initialize(first_token, second_token, third_token = nil)
      @first_token = first_token
      @second_token = second_token
      @third_token = third_token
    end

    def single_quoted_string?
      single_quoted_string_with_contents? ||
        single_quoted_string_without_contents?
    end

    def single_quoted_string
      if single_quoted_string_with_contents?
        SingleQuotedString.new(first_token, third_token, second_token)
      elsif single_quoted_string_without_contents?
        SingleQuotedString.new(first_token, second_token)
      end
    end

    private

    def single_quoted_string_with_contents?
      first_token.single_quoted_string_start? &&
        second_token.string_contents? &&
        third_token.single_quoted_string_end?
    end

    def single_quoted_string_without_contents?
      first_token.single_quoted_string_start? &&
        second_token.single_quoted_string_end?
    end
  end
end
