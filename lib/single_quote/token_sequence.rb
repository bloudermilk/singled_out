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

    end

    def single_quoted_string

    end
  end
end
