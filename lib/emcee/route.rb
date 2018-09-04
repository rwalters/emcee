module Emcee
  class Route
    class << self
      def parse(cmd, library)
        library = Emcee::Library.new(library) if library.is_a?(Hash)

        case cmd
        when %r[^\s*add "(?<title>[^"]+)" "(?<artist>[^"]+)"\s*$]ii
          artist = $~.named_captures["artist"]
          title = $~.named_captures["title"]

          library.add(title, artist)
        when %r[^\s*play "(?<title>[^"]+)"\s*$]i
          title = $~.named_captures["title"]

          library.play(title)
        when %r[^\s*show all\s*$]i
          library.show_all
        when %r[^\s*show unplayed\s*$]i
          library.show_unplayed
        when %r[^\s*show all by "(?<artist>[^"]+)"\s*$]i
          artist = $~.named_captures["artist"]
          library.show_all_by(artist)
        when %r[^\s*show unplayed by "(?<artist>[^"]+)"\s*$]i
          artist = $~.named_captures["artist"]
          library.show_unplayed_by(artist)
        when /^\s*quit\s*/i
          { message: "Bye!", library: library }
        else
          raise Emcee::UnknownCommandError.new(cmd)
        end
      end
    end
  end
end
