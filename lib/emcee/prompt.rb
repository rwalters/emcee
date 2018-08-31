module Emcee
  class Prompt
    class << self
      PROMPT = "> ".freeze

      def prefix
        PROMPT
      end

      def next
        print PROMPT

        gets.strip
      end
    end
  end
end
