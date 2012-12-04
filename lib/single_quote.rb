require "single_quote/source_file"
require "single_quote/version"

module SingleQuote
  def self.fix_file(file)
    contents = File.read(file)
    source_file = SourceFile.new(contents)
    File.open(file, "w") { |f| f.write(source_file.fixed_source) }
  end
end
