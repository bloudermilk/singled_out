require "spec_helper"

require "single_quote/token_sequence"

describe SingleQuote::TokenSequence do
  describe "#single_quoted_string?" do
    subject do
      SingleQuote::TokenSequence.new(first_token, second_token, third_token)
    end

    let(:first_token) { mock(single_quoted_string_start?: false) }

    let(:second_token) do
      mock(string_contents?: false, single_quoted_string_end?: false)
    end

    let(:third_token) { mock(single_quoted_string_end?: false) }

    context "when the first token is the start of a single quoted string" do
      before { first_token.stub(single_quoted_string_start?: true) }

      context "and the second token is the contents of a string" do
        before { second_token.stub(string_contents?: true) }

        context "and the third token is the end of a single quoted string" do
          before { third_token.stub(single_quoted_string_end?: true) }

          it "returns true" do
            subject.should be_single_quoted_string
          end
        end
      end

      context "and the second token is the end of a single quoted string" do
        before { second_token.stub(single_quoted_string_end?: true) }

        it "returns true" do
          subject.should be_single_quoted_string
        end
      end
    end
  end
end
