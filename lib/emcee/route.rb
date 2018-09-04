module Emcee
  class Route
    class << self
      def parse(cmd, library)
        case cmd
        when %r[^\s*add "(?<title>[^"]+)" "(?<artist>[^"]+)"\s*$]ii
          title  = $~.named_captures["title"]
          artist = $~.named_captures["artist"]

          raise Emcee::DuplicateTitleError.new(title) unless library[title].nil?
          library[title] = { artist: artist, played: false }

          message = %Q[Added "#{title}" by #{artist}]
          {message: message, library: library}
        when %r[^\s*play "(?<title>[^"]+)"\s*$]i
          title = $~.named_captures["title"]

          raise Emcee::TitleNotFoundError.new(title) if library[title].nil?

          library[title][:played] = true

          { message: %Q[You're listening to "#{title}"], library: library }
        when %r[^\s*show all\s*$]i
          msg =
            library.each.map do |elem|
              title = elem.first
              artist = elem.last[:artist]
              played = elem.last[:played] ? "played" : "unplayed"

              %Q["#{title}" by #{artist} (#{played})]
            end.join("\n")

            { message: msg, library: library }
        when %r[^\s*show unplayed\s*$]i
          msg =
            library.each.reject{|elem| elem.last[:played] }.map do |elem|
              title = elem.first
              artist = elem.last[:artist]

              %Q["#{title}" by #{artist}]
            end.join("\n")

            { message: msg, library: library }
        when %r[^\s*show all by "(?<artist>[^"]+)"\s*$]i
          artist = $~.named_captures["artist"]

          msg =
            library
              .each
              .select{|elem| elem.last[:artist] == artist }
              .map do |elem|
                title = elem.first
                artist = elem.last[:artist]
                played = elem.last[:played] ? "played" : "unplayed"

                %Q["#{title}" by #{artist} (#{played})]
              end.join("\n")

            { message: msg, library: library }
        when %r[^\s*show unplayed by "(?<artist>[^"]+)"\s*$]i
          artist = $~.named_captures["artist"]

          msg =
            library
              .each
              .reject{|elem| elem.last[:played] }
              .select{|elem| elem.last[:artist] == artist }
              .map do |elem|
                title = elem.first
                artist = elem.last[:artist]

                %Q["#{title}" by #{artist}]
              end.join("\n")

            { message: msg, library: library }
        when /^\s*quit\s*/i
          { message: "Bye!", library: library }
        else
          raise Emcee::UnknownCommandError.new(cmd)
        end
      end
    end
  end
end
