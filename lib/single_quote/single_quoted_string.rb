module SingleQuote
  class SingleQuotedString
    attr_reader :start_token, :contents_token, :end_token

    def initialize(start_token, contents_token, end_token)
      @start_token = start_token
      @contents_token = contents_token
      @end_token = end_token
    end

    def new_contents
    end
  end
end
