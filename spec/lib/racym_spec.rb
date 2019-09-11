require_relative '../../lib/racym'

# Stub class for Rails.application.config
class Rails
  def self.application
    self
  end

  def self.config
    self
  end
end

describe "#racym" do
  context "with a single argument" do
    before { allow(Rails).to receive(:foo).and_return :bar }

    it "returns it" do
      expect(racym :foo).to eq :bar
    end
  end

  context "with a single argument that's a proc" do
    before { allow(Rails).to receive(:foo).and_return ->{ :bar } }

    it "calls it" do
      expect(racym :foo).to eq :bar
    end
  end

  context "with multiple args" do
    before         { allow(Rails).to receive(:foo).and_return some_obj  }
    let(:some_obj) { double "something", bar: :biz }

    it "calls the chain" do
      expect(racym :foo, :bar).to eq :biz
    end
  end
end

describe "#racym_set" do
  pending
end

describe "#racym_undo!" do
  pending
end
