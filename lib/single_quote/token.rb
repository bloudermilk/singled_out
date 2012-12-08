module SingleQuote
  class Token
    STRING_START_TYPE = :on_tstring_beg
    STRING_END_TYPE = :on_tstring_end
    STRING_CONTENTS_TYPE = :on_tstring_content
    SYMBOL_START_TYPE = :on_symbeg

    SINGLE_QUOTE = "'"
    SINGLE_QUOTED_SYMBOL = ":'"

    attr_reader :type, :contents

    def initialize(type, contents)
      @type = type
      @contents = contents
    end

    def single_quoted_string_start?
      string_start? && single_quote?
    end

    def single_quoted_string_end?
      string_end? && single_quote?
    end

    def string_start?
      type == STRING_START_TYPE
    end

    def string_end?
      type == STRING_END_TYPE
    end

    def string_contents?
      type == STRING_CONTENTS_TYPE
    end

    def single_quote?
      contents == SINGLE_QUOTE
    end

    def single_quoted_symbol_start?
      contents == SINGLE_QUOTED_SYMBOL && type == SYMBOL_START_TYPE
    end
  end
end
