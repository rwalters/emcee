module Emcee
  class Prompt
    PROMPT = "> ".freeze

    class << self
      def print_prefix
        print PROMPT
      end

      def next
        print_prefix

        gets.strip
      end
    end
  end
end
