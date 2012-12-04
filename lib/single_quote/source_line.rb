class SingleQuote::SourceLine
  def initialize(source)
    @source = source
  end

  def self.from_string(string)
    string.lines.to_a.map do |string_line|
      new(string_line)
    end
  end
end
