require "spec_helper"

require "single_quote/token"

describe SingleQuote::Token do
  describe "#single_quoted_string_start?" do
    subject { described_class.new(double, type, contents) }

    context "when the type is :on_tstring_beg" do
      let(:type) { :on_tstring_beg }

      context "when the contents are a single quote" do
        let(:contents) { "'" }

        it "returns true" do
          subject.should be_single_quoted_string_start
        end
      end

      context "when the contents are a double quote" do
        let(:contents) { "\"" }

        it "returns false" do
          subject.should_not be_single_quoted_string_start
        end
      end
    end

    context "when the type is not :on_tstring_beg" do
      let(:type) { :on_something_else }

      context "when the contents are a single quote" do
        let(:contents) { "'" }

        it "returns false" do
          subject.should_not be_single_quoted_string_start
        end
      end

      context "when the contents are a double quote" do
        let(:contents) { '"' }

        it "returns false" do
          subject.should_not be_single_quoted_string_start
        end
      end
    end
  end

  describe "#single_quoted_string_end?" do
    subject { described_class.new(double, type, contents) }

    context "when the type is :on_tstring_end" do
      let(:type) { :on_tstring_end }

      context "when the contents are a single quote" do
        let(:contents) { "'" }

        it "returns true" do
          subject.should be_single_quoted_string_end
        end
      end

      context "when the contents are a double quote" do
        let(:contents) { '"' }

        it "returns false" do
          subject.should_not be_single_quoted_string_end
        end
      end
    end

    context "when the type is not :on_tstring_beg" do
      let(:type) { :on_something_else }

      context "when the contents are a single quote" do
        let(:contents) { "'" }

        it "returns false" do
          subject.should_not be_single_quoted_string_end
        end
      end

      context "when the contents are a double quote" do
        let(:contents) { '"' }

        it "returns false" do
          subject.should_not be_single_quoted_string_end
        end
      end
    end
  end

  describe "#string_contents?" do
    subject { described_class.new(double, type, double) }

    context "when the type is :on_tstring_content" do
      let(:type) { :on_tstring_content }

      it "returns true" do
        subject.should be_string_contents
      end
    end

    context "when the type is not :on_tstring_content" do
      let(:type) { :on_whatever }

      it "returns false" do
        subject.should_not be_string_contents
      end
    end
  end
end
