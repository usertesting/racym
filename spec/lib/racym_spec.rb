begin
  require "coveralls"
  Coveralls.wear!
rescue LoadError
end

require_relative '../../lib/racym'

# Stub class for Rails.application.config
class Rails
  class << self
    attr_accessor :racym_cache
    attr_accessor :foo

    def application
      self
    end

    def config
      self
    end
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
  before { Rails.racym_cache = {} }
  before { Rails.foo = :orig_value }

  it "stores it in the racym_cache for later retreival" do
    expect {
      racym_set :foo, :biz
    }.to change { Rails.racym_cache["foo"] }.to [:orig_value, :biz]
  end

  it "sets it in the config" do
    expect {
      racym_set :foo, :biz
    }.to change { racym :foo }.to :biz
  end
end

describe "#racym_undo!" do
  before { Rails.racym_cache = {"foo" => [:orig_value, :current_override]} }
  before { Rails.foo = :current_override }

  it "restores the value from the cache" do
    expect {
      racym_undo!
    }.to change { racym :foo }.from(:current_override).to :orig_value
  end
end
