module Emcee
  class Library
    attr_reader :library

    def initialize(library = {})
      @library = library
    end

    def add(title, artist)
      raise Emcee::DuplicateTitleError.new(title) unless library[title].nil?

      library[title] = { artist: artist, played: false }
      message = %Q[Added "#{title}" by #{artist}]

      {message: message, library: self}
    end

    def play(title)
      raise Emcee::TitleNotFoundError.new(title) if library[title].nil?

      library[title][:played] = true

      { message: %Q[You're listening to "#{title}"], library: self }
    end

    def show_all
      msg =
        library.each.map do |elem|
          title = elem.first
          artist = elem.last[:artist]
          played = elem.last[:played] ? "played" : "unplayed"

          %Q["#{title}" by #{artist} (#{played})]
        end.join("\n")

        { message: msg, library: self }
    end

    def show_unplayed
      msg =
        unplayed(library).each.map do |elem|
          title = elem.first
          artist = elem.last[:artist]

          %Q["#{title}" by #{artist}]
        end.join("\n")

        { message: msg, library: self }
    end

    def show_all_by(artist)
      msg =
        by_artist(artist, library)
        .each
        .map do |elem|
          title = elem.first
          artist = elem.last[:artist]
          played = elem.last[:played] ? "played" : "unplayed"

          %Q["#{title}" by #{artist} (#{played})]
        end.join("\n")

        { message: msg, library: self }
    end

    def show_unplayed_by(artist)
      msg =
        by_artist(artist, unplayed(library))
        .each
        .map do |elem|
          title = elem.first
          artist = elem.last[:artist]

          %Q["#{title}" by #{artist}]
        end.join("\n")

        { message: msg, library: self }
    end

    private

    def unplayed(lib)
      lib.each.reject{|elem| elem.last[:played] }.to_h
    end

    def by_artist(artist, lib)
      lib.each.select{|elem| elem.last[:artist] == artist }.to_h
    end
  end
end
