require "single_quote/line_patch"

module SingleQuote
  class SingleQuotedString
    attr_reader :start_token, :contents_token, :end_token

    def initialize(start_token, end_token, contents_token = nil)
      @start_token = start_token
      @end_token = end_token
      @contents_token = contents_token
    end

    def contents
      contents_token ? contents_token.contents : ""
    end

    def new_contents
      new_string = ""

      contents.each_char.each_with_index do |char, index|
        if char == "\\"
          new_string << "\\\\"
        elsif char == "\""
          new_string << "\\\""
        elsif char == "#"
          new_string << "\\#"
        else
          new_string << char
        end
      end

      new_string
    end

    def double_quoted_string
      "\"#{new_contents}\""
    end

    def to_s
      "'#{contents}'"
    end

    def line_patches
      new_lines.each_with_index.map do |new_line, index|
        row = start_token.row + index
        length = lines[index].length
        column = index.zero? ? start_token.column : 0

        LinePatch.new(row, column, length, new_line)
      end
    end

    def lines
      to_s.split($/)
    end

    def new_lines
      double_quoted_string.split($/)
    end
  end
end
