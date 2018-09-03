require 'spec_helper'

RSpec.describe Emcee::Route do
  subject { described_class.parse(cmd, library) }

  let(:library) { { _titles: {} } }
  let(:title)   { "A Night at the Opera" }
  let(:artist)  { "Queen" }

  context "add an album" do
    let(:cmd) { %Q[add "#{title}" "#{artist}"] }
    let(:msg) { %Q[Added "#{title}" by #{artist}] }
    let(:new_lib) { { _titles: { title => true }, "Queen" => [{title: title, played: false}] } }

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

  context "play an album"
  context "show all albums"
  context "show unplayed albums"
  context "show all albums by an artist"
  context "show unplayed albums by artist"
  context "quit the terminal"
end
