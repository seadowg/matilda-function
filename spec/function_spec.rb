require 'minitest/autorun'
require 'matilda-function'

describe "recursive" do
  it "creates a recursive function" do
    func = recursive { |this, i|
      if i < 1
        i
      else
        this.call(i - 1)
      end
    }

    func.call(10).must_equal(0)
  end

  it "returns an instance of Proc" do
    func = recursive { |this| this.call }
    func.kind_of?(Proc).must_equal true
  end
end

describe "Proc" do
  describe "#<<" do
    it "returns a new Proc" do
      func = Proc.new {} << Proc.new {}
      func.kind_of?(Proc).must_equal true
    end

    it "executing the result chains argument and receiver" do
      sort = Proc.new { |array| array.sort }
      reverse = Proc.new { |array| array.reverse }

      (sort << reverse).call([1,4,2,3]).must_equal [4,3,2,1]
    end
  end

  describe "#+" do
    it "returns a Proc" do
      func = Proc.new {} + Proc.new {}
      func.kind_of?(Proc).must_equal true
    end

    it "returns a Proc that executes the callee and arg in order" do
      sort = Proc.new { |array| array.sort! }
      reverse = Proc.new { |array| array.reverse! }

      (sort + reverse).call([1,4,2,3]).must_equal [4,3,2,1]
    end
  end
end
