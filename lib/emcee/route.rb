module Emcee
  class Route
    class << self
      def parse(cmd, library)
        case cmd
        when /add \"([^\"]+)\" \"([^\"]+)\"/i
          title  = $1
          artist = $2

          raise Emcee::DuplicateTitleError if library[:_titles][title]
          library[:_titles][title] = true

          library[artist] ||= []
          library[artist] << { title: title, played: false }

          message = %Q[Added "#{title}" by #{artist}]
          {message: message, library: library}
        end
      end
    end
  end
end
