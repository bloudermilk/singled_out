# encoding: utf-8

require "spec_helper"

require "single_quote"

describe "UTF-8 compatibility" do
  it "supports fancy UTF-8 strings" do
    file = SingleQuote::SourceFile.new("get 'こんにちは/世界', :controller => 'news', :action => 'index'")
    file.fixed_source.should eq("get \"こんにちは/世界\", :controller => \"news\", :action => \"index\"")
  end
end
