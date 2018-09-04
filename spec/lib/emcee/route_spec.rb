require 'spec_helper'

RSpec.describe Emcee::Route do
  subject { described_class.parse(cmd, library) }

  let(:library) { {  } }
  let(:title)   { "A Night at the Opera" }
  let(:artist)  { "Queen" }

  context "add an album" do
    let(:cmd) { %Q[add "#{title}" "#{artist}"] }
    let(:msg) { %Q[Added "#{title}" by #{artist}] }
    let(:new_lib) { { title => {artist: "Queen", played: false} } }

    it "adds the new album" do
      expect(subject).to eq({ message: msg, library: new_lib })
    end

    context "that's a duplicate album" do
      let(:library) { new_lib }

      it "raises an error" do
        expect { subject }.to raise_error(Emcee::DuplicateTitleError)
      end
    end
  end

  context "play an album" do
    let(:cmd) { %Q[play "#{title}"] }
    let(:msg) { %Q[You're listening to "#{title}"] }
    let(:library) do
      { title => { played: false, artist: "Queen" } }
    end
    let(:new_lib) do
      { title => { played: true, artist: "Queen" } }
    end

    it "marks the album as played" do
      expect(subject).to eq({ message: msg, library: new_lib })
    end

    context "album not found" do
      let(:title) { {} }

      it "raises an error" do
        expect { subject }.to raise_error(Emcee::TitleNotFoundError)
      end
    end
  end

  context "show" do
    context "show all" do
      let(:cmd) { %Q[show all] }
      let(:library) do
        {
          title => {artist: "Queen", played: false},
          "Sheer Heart Attack"  => { artist: "Queen", played: true },
          "News of the World"   => { artist: "Queen", played: false },
          "Night Work" => { artist: "Scissor Sisters", played: true},
        }
      end

      let(:msg) do
        library.keys.map do |title|
          artist = library[title][:artist]
          played = library[title][:played] ? "played" : "unplayed"

          %Q["#{title}" by #{artist} (#{played})]
        end
        .join("\n")
      end

      it "lists all albums and played status" do
        expect(subject).to eq( { message: msg, library: library } )
      end
    end

    context "show unplayed" do
      let(:cmd) { %Q[show unplayed] }
      let(:library) do
        {
          title => {artist: "Queen", played: false},
          "Sheer Heart Attack"  => { artist: "Queen", played: true },
          "News of the World"   => { artist: "Queen", played: false },
          "Night Work" => { artist: "Scissor Sisters", played: true},
        }
      end

      let(:msg) do
        library
          .keys
          .reject{|k| library[k][:played] }
          .map do |title|
            artist = library[title][:artist]

            %Q["#{title}" by #{artist}]
          end
          .join("\n")
      end

      it "lists all albums and played status" do
        expect(subject).to eq( { message: msg, library: library } )
      end
    end

    context "show all albums by an artist"
    context "show unplayed albums by artist"
  end

  context "quit the terminal"
end
