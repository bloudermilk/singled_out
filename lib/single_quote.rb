require "single_quote/source_file"
require "single_quote/version"

module SingleQuote
  def self.fix_file!(path)
    SourceFile.new(path).fix!
  end
end
