require "spec_helper"

require "single_quote"

describe "underscores" do
  let(:start_source) do
    <<-RUBY
      autoload :SomeClass, 'awesome_gem/some_class'
    RUBY
  end

  let(:end_source) do
    <<-RUBY
      autoload :SomeClass, "awesome_gem/some_class"
    RUBY
  end

  specify "they work" do
    file = SingleQuote::SourceFile.new(start_source)
    file.fixed_source.should eq(end_source)
  end
end
