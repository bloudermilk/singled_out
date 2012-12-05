require "spec_helper"

require "single_quote"

describe "complicated files" do
  let(:complicated_source) do
    <<-RUBY
    require 'some_things'

    class Foo
      FOOBAR = '123'; FOOBUTT = 'lololol'
      def lol
        puts 'hello
        world
        multiline
        string'
      end
    end
    RUBY
  end

  let(:fixed_complicated_source) do
    <<-RUBY
    require "some_things"

    class Foo
      FOOBAR = "123"; FOOBUTT = "lololol"
      def lol
        puts "hello
        world
        multiline
        string"
      end
    end
    RUBY
  end

  specify "'aint nuthin' to trip over" do
    file = SingleQuote::SourceFile.new(complicated_source)
    file.fixed_source.should eq(fixed_complicated_source)
  end
end
