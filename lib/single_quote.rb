require "single_quote/program"
require "single_quote/version"

module SingleQuote
  def self.fix_file(file)
    contents = File.read(file)
    program = Program.new(contents)

    if program.changes?
      File.open(file, "w") { |f| f.write(program.patched_source) }

      true
    else
      false
    end
  end
end
