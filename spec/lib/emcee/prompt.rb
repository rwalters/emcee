require 'spec_helper'

RSpec.describe Emcee::Prompt do
  subject { described_class }

  it "prints the expected characters" do
    expect(subject.prefix).to eq "> "
  end

  it "strips and returns the input"
end
