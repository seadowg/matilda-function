require 'minitest/autorun'
require 'ruby-function'

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
