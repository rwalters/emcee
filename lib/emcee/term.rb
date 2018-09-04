module Emcee
  class Term
    attr_reader :library

    def initialize(library = {})
      @library = library
    end

    def start
      puts "Welcome to your music collection!\n\n"

      loop do
        cmd = Emcee::Prompt.next

        begin
          result = Emcee::Route.parse(cmd, library)
          puts result[:message]

          @library = result[:library]
          break if result[:message] == "Bye!"
        rescue Emcee::RouteError => e
          puts "Error: #{e.message}"
        end
      end
    end
  end
end
