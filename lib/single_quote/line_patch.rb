class SingleQuote::LinePatch
  attr_reader :row, :column, :length, :contents

  def initialize(row, column, length, contents)
    @row = row
    @column = column
    @length = length
    @contents = contents
  end
end
