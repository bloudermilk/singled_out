module SingleQuote
  class Token
    STRING_START_TYPE = :on_tstring_beg
    STRING_CONTENTS_TYPE = :on_tstring_content
    STRING_END_TYPE = :on_tstring_end

    SINGLE_QUOTE = "'"

    attr_reader :position, :type, :contents

    def initialize(position, type, contents)
      @position = position
      @type = type
      @contents = contents
    end

    def single_quoted_string_start?
      string_start? && single_quote?
    end

    def single_quoted_string_end?
      string_end? && single_quote?
    end

    def string_contents?
      type == STRING_CONTENTS_TYPE
    end

    def string_start?
      type == STRING_START_TYPE
    end

    def string_end?
      type == STRING_END_TYPE
    end

    def single_quote?
      contents == SINGLE_QUOTE
    end
  end
end
