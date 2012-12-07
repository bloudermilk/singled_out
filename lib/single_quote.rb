require "single_quote/source_file"
require "single_quote/version"

module SingleQuote
  def self.fix_file(file)
    contents = File.read(file)
    source_file = SourceFile.new(contents)

    if source_file.single_quoted_strings?
      File.open(file, "w") { |f| f.write(source_file.fixed_source) }

      true
    else
      false
    end
  end
end
