n = 1000000

class X
  def self.call(a,b)
    a == b
  end

  def initialize(a,b)
    @a = a
    @b = b
  end
  def call
    @a == @b
  end
end

n.times{ X.new(1,1).call }

