module Emcee
  class Route
    class << self
      def parse(cmd, library)
        case cmd
        when %r[^\s*add "(?<title>[^"]+)" "(?<artist>[^"]+)"\s*$]ii
          title  = $~.named_captures["title"]
          artist = $~.named_captures["artist"]

          raise Emcee::DuplicateTitleError.new(title) if library[:_titles][title]
          library[:_titles][title] = { played: false }

          library[artist] ||= []
          library[artist] << title

          message = %Q[Added "#{title}" by #{artist}]
          {message: message, library: library}
        when /^\s*play \"(?<title>[^\"]+)\"\s*$/i
          title = $~.named_captures["title"]

          raise Emcee::TitleNotFoundError.new(title) unless library[:_titles][title]

          library[:_titles][title][:played] = true

          { message: %Q[You're listening to "#{title}"], library: library }
        end
      end
    end
  end
end
