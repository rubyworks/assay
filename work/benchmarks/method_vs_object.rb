require 'benchmark'

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


n = 1000000
Benchmark.bm do |x|
  x.report("method") { n.times{ X.call(1,1) } }
  x.report("object") { n.times{ X.new(1,1).call } }
end

