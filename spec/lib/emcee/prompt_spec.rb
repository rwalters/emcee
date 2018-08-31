require 'spec_helper'

RSpec.describe Emcee::Prompt do
  subject { described_class }

  context "::PROMPT" do
    it "matches the expected characters" do
      expect(Emcee::Prompt::PROMPT).to eq "> "
    end
  end

  context ".print_prefix" do
    it "prints the prompt prefix to STDOUT" do
      expect{ subject.print_prefix }.to output(Emcee::Prompt::PROMPT).to_stdout
    end
  end

  context ".next" do
    before do
      allow(subject).to receive(:print_prefix)
      allow(subject).to receive(:gets).and_return(test_input)
    end

    let(:rand_ws_char) { ->{ [' ', "\t", "\n"].sample } }
    let(:rand_ws) { ->{ rand(0..4).times.map{ rand_ws_char.call }.join('') } }

    let(:test_input)  { "#{ rand_ws.call }test  \t input#{ ' ' * rand(0..4) }\n" }
    let(:clean_input) { test_input.sub(/\A\s+/, '').sub(/\s+\z/, '') }

    it "strips and returns the user's input" do
      expect(subject.next).to eq clean_input
    end
  end
end
