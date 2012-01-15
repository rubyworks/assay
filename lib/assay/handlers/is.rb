# TODO: What about BasicObject ?

class Object

  #
  #
  #
  def is(matcher=nil)
    if matcher
      matcher === self
    else
      ToBe.new(self)
    end
  end

end

