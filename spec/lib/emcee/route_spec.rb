require 'spec_helper'

RSpec.describe Emcee::Route do
  subject { described_class.parse(cmd, library) }

  let(:library) { { _titles: {} } }
  let(:title)   { "A Night at the Opera" }
  let(:artist)  { "Queen" }

  context "add an album" do
    let(:cmd) { %Q[add "#{title}" "#{artist}"] }
    let(:msg) { %Q[Added "#{title}" by #{artist}] }
    let(:new_lib) { { _titles: { title => {played: false} }, "Queen" => [title] } }

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
    let(:library) { { _titles: { title => {played: false} }, "Queen" => [title] } }
    let(:new_lib) { { _titles: { title => {played: true} }, "Queen" => [title] } }

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

  context "show all albums"
  context "show unplayed albums"
  context "show all albums by an artist"
  context "show unplayed albums by artist"
  context "quit the terminal"
end
