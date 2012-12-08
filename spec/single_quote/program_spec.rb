# encoding: utf-8

require "spec_helper"

require "single_quote/program"

describe SingleQuote::Program do
  subject { described_class.new(source) }

  let(:source) { double }

  describe "#patched_source" do
    context "when #source contains single quoted strings" do
      let(:source) { "'Hello World'\n'You rock!'" }

      it "returns double quoted strings" do
        subject.patched_source.should eq("\"Hello World\"\n\"You rock!\"")
      end
    end

    context "when #source contains more than one string on a line" do
      let(:source) { "'Hello World' + 'You rock!'" }

      it "doesn't do weird things" do
        subject.patched_source.should eq("\"Hello World\" + \"You rock!\"")
      end
    end

    context "when #source contains UTF-8 characters" do
      let(:source) { "get 'こんにちは/世界', :controller => 'news', :action => 'index'" }

      it "doesn't do weird things" do
        subject.patched_source.should eq("get \"こんにちは/世界\", :controller => \"news\", :action => \"index\"")
      end
    end

    context "when #source contains single quoted symbols" do
      let(:source) { "puts :'foo bar'" }

      it "turns those suckers into double quoted symbols" do
        subject.patched_source.should eq("puts :\"foo bar\"")
      end
    end
  end
end

